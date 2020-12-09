-- CTE com múltiplas definições
WITH cte_ValorMaximo (ValorMaximo, DataPedido, IdCliente)
AS
  (
      SELECT max(unitprice * qty) AS ValorMaximo, 
	                   O.orderdate AS DataPedido, 
					   O.custid   AS IdCliente 
	  FROM Sales.OrderDetails AS OD
		INNER JOIN Sales.Orders AS O ON O.orderid = OD.orderid
	  GROUP BY orderdate, custid
  ),
 cte_Clientes (nomeCliente, custid)
AS 
 (
      SELECT DISTINCT contactname, C.custid AS nomeCliente FROM Sales.Customers AS C
	                                  --  INNER JOIN cte_ValorMaximo AS VM ON C.custid = VM.IdCliente
 )
SELECT * FROM cte_Clientes AS C JOIN cte_ValorMaximo VM ON C.custid = VM.IdCliente



-- RECURSIVIDADE
WITH CTE_Numerico (Nivel, Numero) 
AS
(
    -- Âncora (nível 1)
    SELECT 1 AS Nivel, 1 AS Numero
    
    UNION ALL

    -- Níveis recursivos (Níveis N)
    SELECT Nivel + 1, Numero + Numero 
    FROM CTE_Numerico
    WHERE Numero < 2048
 )
SELECT *
FROM CTE_Numerico;

--
--RECURSIVIDADE
WITH DirectReports(ManagerID, EmployeeID, Title, EmployeeLevel) AS   
(  
    SELECT mgrid as ManagerID, empid as EmployeeID, title, 0 AS EmployeeLevel  
    FROM HR.Employees   
    WHERE mgrid IS NULL  
    UNION ALL  
    SELECT e.mgrid, e.empid, e.Title, EmployeeLevel + 1  
    FROM HR.Employees AS e  
        INNER JOIN DirectReports AS d  
        ON e.mgrid = d.EmployeeID   
)  
SELECT ManagerID, EmployeeID, Title, EmployeeLevel   
FROM DirectReports  
ORDER BY ManagerID; 



--
