-- XML RAW
SELECT Customer.custid, Customer.companyname,
 [Order].orderid, [Order].orderdate
FROM Sales.Customers AS Customer
 INNER JOIN Sales.Orders AS [Order]
 ON Customer.custid = [Order].custid
WHERE Customer.custid <= 2
 AND [Order].orderid %2 = 0
ORDER BY Customer.custid, [Order].orderid
FOR XML RAW;

--XML AUTO
SELECT TOP 1 [co:Customer].custid      AS [co:custid],
			 [co:Customer].companyname AS [co:companyname],
			 [co:Order].orderid        AS [co:orderid],
			 [co:Order].orderdate      AS [co:orderdate]
FROM Sales.Customers             AS [co:Customer]
 INNER JOIN Sales.Orders         AS [co:Order]
 ON [co:Customer].custid = [co:Order].custid
WHERE [co:Customer].custid <= 2
 AND [co:Order].orderid %2 = 0
ORDER BY [co:Customer].custid, [co:Order].orderid -- IMPORTANTE UTILIZAR A CLÁUSULA ORDER BY
FOR XML AUTO, -- FORMATA O XML DE FORMA AUTOMATICA 
        ELEMENTS, -- O RESULTADO É UM XML "ELEMENT-CENTRIC" 
		ROOT('CustomersOrders'); -- GERA UM NÓ RAIZ

-- DIFERENÇA NA ORDEM DAS COLUNAS
--SELECT TOP 1 [co:Order].orderid     AS [co:custid],
--			 [co:Order].orderdate      AS [co:orderdate],
--			 [co:Customer].companyname AS [co:companyname],
--			 [co:Customer].custid      AS [co:custid]
--FROM Sales.Customers             AS [co:Customer]
-- INNER JOIN Sales.Orders         AS [co:Order]
-- ON [co:Customer].custid = [co:Order].custid
--WHERE [co:Customer].custid <= 2
-- AND [co:Order].orderid %2 = 0
--ORDER BY [co:Customer].custid, [co:Order].orderid
--FOR XML AUTO, -- FORMATA O XML DE FORMA AUTOMATICA 
--        ELEMENTS, -- O RESULTADO É UM XML "ELEMENT-CENTRIC" 
--		ROOT('CustomersOrders'); -- GERA UM NÓ RAIZ

-- FOR XML PATH
SELECT TOP 1 C.categoryid, C.categoryname, C.description FROM Production.Categories C
FOR XML PATH

SELECT TOP 1 C.categoryid AS "@id", C.categoryname, C.description FROM Production.Categories C
FOR XML PATH ('InfoCategorias');

SELECT TOP 1 C.categoryid AS "@id", C.categoryname, C.description FROM Production.Categories C
FOR XML PATH ('Categoria'), ROOT('XMLCategorias')

  
--Exercício XML
SELECT TOP 1 P.productid    AS "@CodigoProduto"
      ,P.productname  AS "@NomeProduto"
	  ,C.categoryname AS [Categoria]
	  ,c.description  AS [Descrição]
FROM Production.Products AS P
  INNER JOIN Production.Categories AS C ON P.categoryid = C.categoryid
FOR XML PATH ('Produto'), ELEMENTS, ROOT('ProdutoCategoria');


-- OPENXML
DECLARE @DocHandle AS INT;
DECLARE @XmlDocument AS NVARCHAR(1000);
SET @XmlDocument = N'
<CustomersOrders>
 <Customer custid="1">
 <companyname>Customer NRZBB</companyname>
 <Order orderid="10692">
 <orderdate>2015-10-03T00:00:00</orderdate>
 </Order>
 <Order orderid="10702">
 <orderdate>2015-10-13T00:00:00</orderdate>
 </Order>
 <Order orderid="10952">
 <orderdate>2016-03-16T00:00:00</orderdate>
 </Order>
 </Customer>
 <Customer custid="2">
 <companyname>Customer MLTDN</companyname>
 <Order orderid="10308">
 <orderdate>2014-09-18T00:00:00</orderdate>
 </Order>
 <Order orderid="10926">
 <orderdate>2016-03-04T00:00:00</orderdate>
 </Order>
 </Customer>
</CustomersOrders>';
EXEC sys.sp_xml_preparedocument @DocHandle OUTPUT, @XmlDocument;

SELECT *
FROM OPENXML (@DocHandle, '/CustomersOrders/Customer', 11)
 WITH (custid INT,
 companyname NVARCHAR(40));
-- Remove o DOM
EXEC sys.sp_xml_removedocument @DocHandle;

--XQUERY
DECLARE @x AS XML = N'
<CustomersOrders>
  <Customer custid="1">
 	<companyname>Customer NRZBB</companyname>
		<Order orderid="10692">
		<orderdate>2015-10-03T00:00:00</orderdate>
	</Order>
	<Order orderid="10702">
		<orderdate>2015-10-13T00:00:00</orderdate>
	</Order>
		<Order orderid="10952">
		<orderdate>2016-03-16T00:00:00</orderdate>
	</Order>
  </Customer>
  <Customer custid="2">
	<companyname>Customer MLTDN</companyname>
	<Order orderid="10308">
		<orderdate>2014-09-18T00:00:00</orderdate>
	</Order>
	<Order orderid="10952">
		<orderdate>2016-03-04T00:00:00</orderdate>
	</Order>
  </Customer>
</CustomersOrders>';
SELECT @x.query('for $i in CustomersOrders/Customer/Order
				 let $j := $i/orderdate
				 where $i/@orderid < 10900
				 order by ($j)[1]
				 return
				<Order-orderid-element>
				  <orderid>{data($i/@orderid)}</orderid>
					{$j}
			    </Order-orderid-element>')
 AS [Filtrado, ordenado e reformatado com a cláusula LET];
 /*
 <Order-orderid-element>
       <orderid>10308</orderid>
	   <orderdate>2014-09-18T00:00:00</orderdate>
</Order-orderid-element>
<Order-orderid-element>
       <orderid>10692</orderid>
	   <orderdate>2015-10-03T00:00:00</orderdate>
</Order-orderid-element><Order-orderid-element>
       <orderid>10702</orderid>
	   <orderdate>2015-10-13T00:00:00</orderdate>
</Order-orderid-element>
 */
