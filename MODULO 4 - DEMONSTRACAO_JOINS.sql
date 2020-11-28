USE TSQLV4;
GO

-- INNER JOIN
SELECT * FROM Sales.Orders O
  INNER JOIN Sales.OrderDetails OD ON O.orderid = OD.orderid --AND O.orderid = 10248
  WHERE O.orderid = 10248

--SELECT * FROM Sales.Orders O, Sales.OrderDetails OD WHERE O.orderid = od.orderid -- SQL 89

SELECT * FROM Sales.Orders O
           JOIN Sales.OrderDetails OD ON O.orderid = OD.orderid
WHERE O.orderid = 10248


-- LEFT OUTER JOIN 
SELECT * FROM Sales.Customers C LEFT JOIN Sales.Orders OD ON C.custid = OD.custid --AND C.custid = 1
WHERE C.custid = 1
--WHERE OD.orderid IS NULL;

-- RIGHT OUTER JOIN
SELECT * FROM Production.Products AS P RIGHT JOIN Production.Suppliers AS S ON S.supplierid = P.supplierid AND S.country = N'Japan'
--WHERE S.country = N'Japan';


-- CROSS JOIN
SELECT D.n AS Dia, 
       S.n AS Turno
FROM dbo.Nums AS D
   CROSS JOIN dbo.Nums AS S
WHERE D.n <= 7
  AND S.n <= 3
ORDER BY Dia, Turno;

-- SELF JOIN 
--Funcionarios com gerentes;
SELECT  e.empid, e.lastname,
        e.title, e.mgrid, m.lastname
FROM    HR.Employees AS e
JOIN HR.Employees AS m 
ON e.mgrid=m.empid;


--Funcionarios incluindo os CEOS com id null para gerentes
SELECT  e. empid, e.lastname,
	  e.title, m.mgrid
FROM HR.Employees AS e LEFT OUTER JOIN HR.Employees AS m
ON e.mgrid=m.empid;