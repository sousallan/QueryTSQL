--1 
CREATE OR ALTER VIEW VW_DadosVendas
WITH SCHEMABINDING 
AS 
	SELECT C.custid, companyname, contacttitle, address FROM Sales.Customers AS C
			 LEFT JOIN Sales.Orders AS O ON C.custid = O.custid
	WHERE O.orderid IS NULL
GO
--2
CREATE OR ALTER VIEW Sales.Vw_ExemploVWParticionada
AS
SELECT orderid, 
        custid, 
		 empid, 
     orderdate, 
  requireddate, 
   shippeddate, 
     shipperid, 
	   freight, 
	  shipname, 
   shipaddress, 
      shipcity, 
	 shipregion,
	 shippostalcode,
	 shipcountry
FROM Sales.Orders
WHERE orderdate > '20150101'
UNION ALL
SELECT orderid, 
        custid, 
		 empid, 
     orderdate, 
  requireddate, 
   shippeddate, 
     shipperid, 
	   freight, 
	  shipname, 
   shipaddress, 
      shipcity, 
	 shipregion,
	 shippostalcode,
	 shipcountry
FROM Sales.OrdersBKP
WHERE orderdate < '20150101'
GO
--3
WITH DirectReports(FirstName, ManagerID, EmployeeID, Title, EmployeeLevel) AS   
(  
    SELECT firstname, mgrid as ManagerID, empid as EmployeeID, title, 0 AS EmployeeLevel  
    FROM HR.Employees   
    WHERE mgrid IS NULL 
	
    UNION ALL  

    SELECT e.firstname, e.mgrid, e.empid, e.Title, EmployeeLevel + 1  
    FROM HR.Employees AS e  
        INNER JOIN DirectReports AS d  
        ON e.mgrid = d.EmployeeID   
)  
SELECT FirstName, ManagerID, EmployeeID, Title, EmployeeLevel   
FROM DirectReports  
ORDER BY ManagerID; 





