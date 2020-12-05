USE TSQLV4
GO

SET IDENTITY_INSERT Sales.Customers ON

INSERT INTO Sales.Customers (custid,    companyname,    contactname, contacttitle,     [address],    city, region, postalcode,  country,    phone, fax)
                     VALUES (    92, 'Customer ARS', 'Sousa, Allan',      'Owner', 'Cidade Nova', 'Belém', NULL,         1000, 'Brazil', '929209', null);

INSERT INTO Sales.Customers 
                     VALUES (    93, 'Customer ARS', 'Sousa, Allan',      'Owner', 'Cidade Nova', 'Belém', NULL,         1000, 'Brazil', '929209', null);

SET IDENTITY_INSERT Sales.Customers OFF

SELECT @@IDENTITY 
SELECT SCOPE_IDENTITY()

--
UPDATE C
   SET C.contactname += ' Sousa' 
FROM Sales.Customers C
LEFT JOIN Sales.Orders O ON C.custid = O.custid
WHERE O.orderid IS NULL
  AND c.custid = 93

--Criando uma tabela nova
--SELECT * INTO Production.ProductsDiscountUPDATE FROM Production.ProductsDiscount

CREATE TABLE #OUTPUT (desconto_novo NUMERIC(10,2), desconto_antigo NUMERIC(10,2));

DECLARE crs CURSOR FOR SELECT productId FROM Production.ProductsDiscountUPDATE WHERE discontinued = 1
OPEN crs;
FETCH FROM crs;
 
WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE Production.ProductsDiscountUPDATE
	   SET pricediscount = 0
	OUTPUT inserted.pricediscount, deleted.pricediscount INTO #OUTPUT
	WHERE CURRENT OF crs;

	FETCH FROM crs;
END

CLOSE crs;
DEALLOCATE crs;

SELECT * FROM #OUTPUT
SELECT * FROM Production.ProductsDiscountUPDATE where discontinued = 1

--DROP TABLE #OUTPUT
--DROP TABLE Production.ProductsDiscountUPDATE

---
CREATE TABLE Sales.Origem
(
   Id    INT         NOT NULL, 
   Nome  VARCHAR(30) NOT NULL
);
GO

CREATE TABLE Sales.Destino
(
  Id    INT         NOT NULL,
  Nome  VARCHAR(30) NOT NULL,
  Idade TINYINT     NOT NULL
);
GO

INSERT INTO Sales.Origem VALUES (1, 'João'), (2, 'Maria'), (3, 'Raimundo');
INSERT INTO Sales.Destino VALUES (1, 'João', 20);
GO

MERGE INTO Sales.Destino AS Destino
USING Sales.Origem AS Origem ON  (Destino.Id = Origem.Id)
WHEN NOT MATCHED THEN 
     INSERT (Id, Nome, Idade)
	 VALUES (Origem.Id, Origem.Nome, DATEDIFF(YEAR, '19870927', getdate()))
WHEN MATCHED /*AND Destino.Idade < 20*/ THEN
     UPDATE SET Destino.Nome += ' Sobrenome'
	           ,Destino.Idade += 10;
GO

SELECT * FROM Sales.Origem;
SELECT * FROM Sales.Destino;

DROP TABLE Sales.Origem
DROP TABLE Sales.Destino

---

DECLARE @MyVar Table (Nome VARCHAR(100));

CREATE TABLE #Table (Nome VARCHAR(100));

-- output simples
INSERT INTO #Table (Nome) 
  OUTPUT inserted.Nome 
VALUES ('Allan');

-- output para tabelas temporárias
INSERT INTO #Table (Nome)
   OUTPUT inserted.Nome INTO @MyVar
VALUES ('Allan 2');

-- output update 
UPDATE #Table 
   SET Nome += ' Rodrigues'
OUTPUT inserted.Nome AS Novo_Nome, deleted.Nome AS Nome_Anterior

-- output delete 
DELETE FROM #Table OUTPUT deleted.Nome;


