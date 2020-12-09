USE TSQLV4;
GO

CREAtE VIEW Sales.Vw_EXEMPLO
WITH SCHEMABINDING 
/*
  --Vincula o objeto a esquema. Não permite consultas com '*' dentro da view.
  --Necessário informar o esquema da tabela ou tabelas.
*/
AS 
 SELECT ID, NOME, TELEFONE, Versao FROM dbo.Tabela_1
GO
/*
	ALTER TABLE dbo.Tabela_1 DROP COLUMN Versao;
	DROP TABLE dbo.Tabela_1
*/
GO
CREATE VIEW Sales.Vw_Exemplo2
AS
 SELECT ID, NOME, TELEFONE, VERSAO FROM Tabela_2
GO

/*
ALTER TABLE dbo.Tabela_2 DROP COLUMN Versao
DROP TABLE dbo.Tabela_2
*/

--
CREATE VIEW Sales.Vw_Exemplo3
WITH ENCRYPTION -- CRIPTOGRAFA O CÓDIGO DA VIEW
AS 
  SELECT ID, NOME FROM dbo.Insert_Identity2
GO
-- EXEC SP_HELPTEXT 'Sales.Vw_Exemplo3'

/*
  MODIFICANDO DADOS COM VIEWS
*/
CREATE OR ALTER VIEW Sales.USACustos
 WITH SCHEMABINDING
AS
SELECT
 custid, companyname, contactname, contacttitle, address,
 city, region, postalcode, country, phone, fax
FROM Sales.Customers
WHERE country = N'USA';
GO

INSERT INTO Sales.USACustos(
 companyname, contactname, contacttitle, address,
 city, region, postalcode, country, phone, fax)
VALUES(
 N'Customer AAAAA', N'Contact AAAAA', N'Title AAAAA', N'Address AAAAA', N'Redmond', N'WA', N'11111', N'USA', N'111-1111111', N'111-1111111');

SELECT custid, companyname, country
FROM Sales.Customers
WHERE custid = SCOPE_IDENTITY();
GO

INSERT INTO Sales.USACustos(
 companyname, contactname, contacttitle, address,
 city, region, postalcode, country, phone, fax)
VALUES(
 N'Customer BBBBB', N'Contact BBBBB', N'Title BBBBB', N'Address BBBBB', N'London', NULL, N'22222', N'UK', N'222-2222222', N'222-2222222');

SELECT custid, companyname, country
FROM Sales.Customers
WHERE custid = SCOPE_IDENTITY();
GO

-- WITH CHECK OPTION, garante que o DML realizado na view respeite o filtro aplicado na consulta interna. 
CREATE OR ALTER VIEW Sales.USACustos
 WITH SCHEMABINDING
AS
SELECT
 custid, companyname, contactname, contacttitle, address,
 city, region, postalcode, country, phone, fax
FROM Sales.Customers
WHERE country = N'USA'
WITH CHECK OPTION;
GO


