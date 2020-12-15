/*
[
 {
 "custid":1,
 "companyname":"Customer NRZBB",
 "Order":[
			 {
			 "orderid":10692,
			 "orderdate":"2015-10-03"
			 },
			 {
			 "orderid":10702,
			 "orderdate":"2015-10-13"
			 },
			 {
			 "orderid":10952,
			 "orderdate":"2016-03-16"
			 }
         ]
 },
 {
 "custid":2,
 "companyname":"Customer MLTDN",
 "Order":[
			 {
			 "orderid":10308,
			 "orderdate":"2014-09-18"
			 },
			 {
			 "orderid":10926,
			 "orderdate":"2016-03-04"
			 }
         ]
 }
]
*/

-- Gerando JSON a partir das consultas:
SELECT Customer.custid, Customer.companyname,
       [Order].orderid, [Order].orderdate
FROM Sales.Customers AS Customer INNER JOIN Sales.Orders AS [Order] ON Customer.custid = [Order].custid
WHERE Customer.custid <= 2 AND [Order].orderid %2 = 0
ORDER BY Customer.custid, [Order].orderid
FOR JSON AUTO; -- GERA O JSON DE FORMA AUTOMÁTICA.

SELECT 
       [Order].orderid,
	   Customer.custid,
       Customer.companyname, 
	   [Order].orderdate
FROM Sales.Customers AS Customer INNER JOIN Sales.Orders AS [Order] ON Customer.custid = [Order].custid
WHERE Customer.custid <= 2 AND [Order].orderid %2 = 0
ORDER BY Customer.custid, [Order].orderid
FOR JSON AUTO; -- A ORDEM DAS COLUNAS NA LISTA DO SELECT INFLUENCIA NO RESULTADO GERADO. 


SELECT TOP 1 Customer.custid AS [Cliente.Id],
       Customer.companyname AS [Cliente.NomeCompanhia],
	   [Order].orderid AS [Cliente.Pedido.IdPedido],
	   [Order].orderdate AS [Cliente.Pedido.DataPedido]
FROM Sales.Customers AS Customer INNER JOIN Sales.Orders AS [Order] ON Customer.custid = [Order].custid
WHERE Customer.custid <= 2 AND [Order].orderid %2 = 0
  AND Customer.custid = 1
ORDER BY Customer.custid, [Order].orderid
FOR JSON PATH; -- PODEMOS ESCREVER UM "CAMINHO", PARA O DOCUMENTO GERADO

--[{"Cliente":
--           {"Id":1,
--		    "NomeCompanhia":"Customer NRZBB",
--			"Pedido":{
--			         "IdPedido":10692,
--					 "DataPedido":"2015-10-03"
--					 }
--			}
--}]

-- ROOT : Adiciona um único nivel no ínicio.
-- INCLUDE_NULL_VALUES: Inclui valores nulos na saída. Por Padrão valores nulos são excluídos da saída JSON.
-- WITHOUT_ARRAY_WRAPPER: Remove os Colchetes

SELECT TOP 1 Customer.custid AS [Cliente.Id],
       Customer.companyname AS [Cliente.NomeCompanhia],
	   [Order].orderid AS [Cliente.Pedido.IdPedido],
	   [Order].orderdate AS [Cliente.Pedido.DataPedido]
FROM Sales.Customers AS Customer INNER JOIN Sales.Orders AS [Order] ON Customer.custid = [Order].custid
WHERE Customer.custid <= 2 AND [Order].orderid %2 = 0
  AND Customer.custid = 1
ORDER BY Customer.custid, [Order].orderid
FOR JSON PATH, ROOT('JSON');
--

SELECT TOP 1 Customer.custid AS [Cliente.Id],
       Customer.companyname AS [Cliente.NomeCompanhia],
	   [Order].orderid AS [Cliente.Pedido.IdPedido],
	   [Order].orderdate AS [Cliente.Pedido.DataPedido]
FROM Sales.Customers AS Customer INNER JOIN Sales.Orders AS [Order] ON Customer.custid = [Order].custid
WHERE Customer.custid <= 2 AND [Order].orderid %2 = 0
  AND Customer.custid = 1
ORDER BY Customer.custid, [Order].orderid
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
--


SELECT TOP 1 Customer.custid AS [Cliente.Id],
       Customer.companyname AS [Cliente.NomeCompanhia],
	   [Order].orderid AS [Cliente.Pedido.IdPedido],
	   [Order].orderdate AS [Cliente.Pedido.DataPedido],
	                NULL AS [Cliente.Pedido.Entrega]
FROM Sales.Customers AS Customer INNER JOIN Sales.Orders AS [Order] ON Customer.custid = [Order].custid
WHERE Customer.custid <= 2 AND [Order].orderid %2 = 0
  AND Customer.custid = 1
ORDER BY Customer.custid, [Order].orderid
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;--, INCLUDE_NULL_VALUES;

--TRANSFORMA UM DOCUMENTO JSON PARA UM FORMATO TABULAR
DECLARE @json AS NVARCHAR(MAX) = N'{
									 "Customer":{
									 "Id":1,
									 "Name":"Customer NRZBB",
									 "Order":{
											 "Id":10692,
											 "Date":"2015-10-03",
											 "Delivery":null
											 }
									      }
									}';


--SELECT *
--FROM OPENJSON(@json);


--SELECT *
--FROM OPENJSON(@json)
--WITH
-- (
--	 CustomerId    INT             '$.Customer.Id',
--	 CustomerName  NVARCHAR(20)    '$.Customer.Name',
--	 OrderId       INT             '$.Customer.Order.Id', 
--	 Orders       NVARCHAR(MAX)    '$.Customer.Order' AS JSON
--);


SELECT *
FROM OPENJSON(@json)
WITH
 (
	 CustomerId    INT             '$.Customer.Id',
	 CustomerName  NVARCHAR(20)    '$.Customer.Name',
	 OrderId       INT             '$.Customer.Order.Id', 
	 Orders       NVARCHAR(MAX)    '$.Customer.Order' AS JSON
) AS JSON_TABLE
INNER JOIN Sales.OrderDetails OD ON JSON_TABLE.OrderId = OD.orderid;

-- FUNÇÕES PARA TRATAMENTO JSON
/*
 ISJSON       -- Verifica se o documento é um JSON VÁLIDO
 JSON_QUERY   -- Extrai um array ou objeto de um documento JSON
 JSON_MODIFY  -- Modifica um documento JSON. Atualiza, Deleta ou Insere um elemento no documento JSON
 JSON_VALUE   -- Extrai um valor scalar de um documento JSON.
*/



DECLARE @json2 AS NVARCHAR(MAX) = N'
{
 "Customer":{
 "Id":1,
 "Name":"Customer NRZBB",
 "Order":{
 "Id":10692,
 "Date":"2015-10-03",
 "Delivery":null
 }
 }
}';
-- Update name
SET @json2 = JSON_MODIFY(@json2, '$.Customer.Name', 'Modified first name');
PRINT @json2
-- Delete Id
SET @json2 = JSON_MODIFY(@json2, '$.Customer.Id', NULL)
PRINT @json2
-- Insert last name
SET @json2 = JSON_MODIFY(@json2, '$.Customer.LastName', 'Added last name')
PRINT @json2;

-- 
SELECT JSON_VALUE(@json2, '$.Customer.LastName') AS JSON_VALUES, 
       JSON_QUERY(@json2, '$.Customer.Order')    AS JSON_QUERYS,
	   ISJSON(@json2)                            AS JSON_VALIDO