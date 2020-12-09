-- GROUPING SETS
SELECT shipcountry, shipregion, shipcity, COUNT(*) AS numorders
, GROUPING_ID(shipcountry) AS pais, GROUPING_ID(shipregion) AS regiao, GROUPING_ID(shipcity) AS cidade
FROM Sales.Orders
WHERE shipregion IS NOT NULL
  AND shipcountry = 'Brazil'
GROUP BY GROUPING SETS (
                         ( shipcountry, shipregion, shipcity) ,
						 ( shipcountry, shipregion ),
						 ( shipcountry ),
						 (     )
						 )
--HAVING GROUPING_ID(shipcity) = 1


--
SELECT shipcountry, shipregion, shipcity, COUNT(*) AS numorders
FROM Sales.Orders
WHERE shipregion IS NOT NULL
  AND shipcountry = 'Brazil'
GROUP BY CUBE( shipcountry, shipregion, shipcity)

-- ROLLUP
SELECT shipcountry, shipregion, shipcity, COUNT(*) AS numorders
FROM Sales.Orders
WHERE shipregion IS NOT NULL
   AND shipcountry = 'Brazil'
GROUP BY ROLLUP( shipcountry, shipregion, shipcity);


SELECT custid, YEAR(orderdate) AS ANO, MONTH(orderdate) AS MES, DAY(orderdate) AS DIA, sum(unitprice * qty) AS Total 
 FROM Sales.Orders O INNER JOIN Sales.OrderDetails OD ON O.orderid = OD.orderid
 GROUP BY ROLLUP (custid, YEAR(orderdate), MONTH(orderdate), DAY(orderdate));