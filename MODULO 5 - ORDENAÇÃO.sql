USE TSQLV4;
GO

-- Agrupando os valores nulos primeiro e posteriormente ordena os valores não-nulos
SELECT Custid, orderdate, requireddate, freight, shipname, shipaddress, shipregion FROM Sales.Orders ORDER BY (CASE WHEN shipregion IS NULL THEN 1 ELSE  0 END), shipregion ASC;
-- Atribuindo um valor alto para os nulos afetando sua posição na ordenação. 
SELECT Custid, orderdate, requireddate, freight, shipname, shipaddress, shipregion, shippeddate FROM Sales.Orders ORDER BY CASE WHEN shippeddate IS NULL THEN '9999-12-31' ELSE  shippeddate END ASC

-- TRATANDO O FILTRO COM VALORES NULOS.
SELECT * FROM Sales.Orders
WHERE shipregion IS NOT NULL -- IS NULL

-- 
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY (SELECT NULL)
OFFSET 2 ROWS FETCH FIRST 3 ROWS ONLY;

---Paginação:
DECLARE @pagenum  AS BIGINT = 3
       ,@pagesize AS BIGINT = 20

SELECT * FROM Production.Products
ORDER BY productid
OFFSET (@pagenum - 1) * @pagesize ROWS FETCH NEXT @pagesize ROWS ONLY;
