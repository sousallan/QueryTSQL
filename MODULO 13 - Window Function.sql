USE TSQLV4;
GO

SELECT OD.orderid, 
       O.orderdate,
	   O.custid,
	   OD.unitprice,
	   SUM(UnitPrice) OVER (PARTITION BY O.custId) AS TotalPorCliente,
	   SUM(UnitPrice) OVER () AS TotalGeral,
	   SUM(UnitPrice) OVER (ORDER BY O.OrderDate) AS TotalOrdenadoPorData
FROM Sales.OrderDetails AS OD
         INNER JOIN Sales.Orders O ON OD.orderid = O.orderid
WHERE custid = 85
ORDER BY  O.orderdate;
----

SELECT 
	ROW_NUMBER() OVER (Order by orderdate) AS Linha,
	orderdate AS DataPedido,
	SUM(UnitPrice) OVER(ORDER BY orderdate)
FROM Sales.Orders O INNER JOIN Sales.OrderDetails OD ON O.orderid = OD.orderid;

--

SELECT O.custid,
       UNITPRICE,
	   ORDERDATE,
       SUM(UnitPrice) OVER (
	                          PARTITION BY CustId       -- cria uma partição 
							  ORDER BY O.OrderDate      -- ordena por data
							  ROWS UNBOUNDED PRECEDING  -- começa no primeiro resultado da partição. 
	                        )
FROM Sales.Orders O INNER JOIN Sales.OrderDetails OD ON O.orderid = OD.orderid

SELECT O.custid,
       UNITPRICE, 
	   ORDERDATE,
       SUM(UnitPrice) OVER (
	                          PARTITION BY CustId    -- cria a partição 
							  ORDER BY O.OrderDate   -- ordena por data 
							  ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING -- intervalo de soma entre a linha corrente e 1 linha posterior
	                        )
FROM Sales.Orders O INNER JOIN Sales.OrderDetails OD ON O.orderid = OD.orderid
