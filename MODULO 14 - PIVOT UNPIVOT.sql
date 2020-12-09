USE TSQLV4;
GO

SELECT * FROM
(SELECT productid, YEAR(orderdate) AS Ano, unitprice FROM Sales.OrderDetails OD
         INNER JOIN Sales.Orders O ON OD.orderid = O.orderid) AS T
PIVOT (
       SUM(unitprice)
	   FOR Ano IN ([2014], [2015], [2016])) AS Pivot_Table
WHERE productid = 9
ORDER BY productid;


SELECT productid, YEAR(orderdate) AS Ano, sum(unitprice) FROM Sales.OrderDetails OD INNER JOIN Sales.Orders O ON OD.orderid = O.orderid
WHERE productid = 9
GROUP BY productid, YEAR(orderdate)

-- UNPIVOT

CREATE TABLE #pvt (VendorID INT, Emp1 INT, Emp2 INT,  Emp3 INT, Emp4 INT, Emp5 INT);  
GO  
INSERT INTO #pvt VALUES (1,4,3,5,4,4);  
INSERT INTO #pvt VALUES (2,4,1,5,5,5);  
INSERT INTO #pvt VALUES (3,4,3,5,4,4);  
INSERT INTO #pvt VALUES (4,4,2,5,5,4);  
INSERT INTO #pvt VALUES (5,5,1,5,5,5);  
GO  
-- Unpivot the table.  
SELECT VendorID, Employee, Orders  
FROM   
   (SELECT VendorID, Emp1, Emp2, Emp3, Emp4, Emp5  
   FROM #pvt) p  
UNPIVOT  
   (Orders FOR Employee IN   
      (Emp1, Emp2, Emp3, Emp4, Emp5)  
)AS unpvt;  
GO  

