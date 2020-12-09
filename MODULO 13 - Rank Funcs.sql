SELECT Productid,
       UnitPrice,
	   ROW_NUMBER() OVER (ORDER BY Productid) AS NUMERO_LINHA,
       DENSE_RANK() OVER (PARTITION BY productID
	                      ORDER BY UnitPrice DESC) RANK_SEM_GAPS, -- Cria um rank sem furos
	   PERCENT_RANK() OVER (PARTITION BY ProductID ORDER BY UnitPrice DESC) RANK_PERCENTUAL, -- Calculo o rank relativo da linha em um grupo
	   CUME_DIST () OVER (PARTITION BY ProductId ORDER BY UnitPrice DESC) CUME_DIST, -- Similar ao percent_rank
	   RANK() OVER (PARTITION BY productID
	                      ORDER BY UnitPrice DESC) RANK_COM_GAPS,  -- Cria um rank com furos
	   NTILE(4) OVER (ORDER BY Productid)			  
FROM Sales.OrderDetails
ORDER BY productid

--


SELECT custid, 
       orderid,
       orderdate, 
	   LAG(orderdate) OVER (Order by custid) AS LAG_COL,
	   LEAD(orderdate) OVER (Order by custid) AS LEAD_COL,
	   FIRST_VALUE(orderdate) OVER (PARTITION BY custid ORDER BY orderdate) AS FIRST_VAL,
	   LAST_VALUE(orderdate)  OVER (PARTITION BY custid ORDER BY orderdate ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS LAST_VAL -- criação de frames.
 FROM Sales.Orders                         