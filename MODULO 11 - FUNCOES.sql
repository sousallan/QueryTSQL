CREATE OR ALTER FUNCTION dbo.udf_ValorMaximoDeCompra
( @OrderId INT )
RETURNS NUMERIC(18,2)
AS
BEGIN
  DECLARE @valorMaximo NUMERIC(18,2)

  SELECT @valorMaximo = max(unitprice * qty) from sales.OrderDetails WHERE orderid = @OrderId;

  RETURN @valorMaximo;
END
-----
GO
-- Utilizando a função em uma lista de select.
SELECT orderid, custid, orderdate, dbo.udf_ValorMaximoDeCompra(orderid) as Valor_Maximo FROM Sales.Orders ORDER BY orderid
GO

CREATE OR ALTER FUNCTION dbo.udf_MaxUnitPrice 
(	
   @orderid INT    
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT MAX(OD.UnitPrice) AS Valor_Maximo 
					                FROM Sales.OrderDetails OD
									WHERE OD.orderid =  @orderid 
)
GO

SELECT * FROM dbo.udf_MaxUnitPrice(10471);
--
GO
CREATE OR ALTER FUNCTION dbo.GetSubtree (@mgrid AS INT, @maxlevels AS INT = NULL)
RETURNS @Tree TABLE
(
	 empid INT NOT NULL PRIMARY KEY,
	 mgrid INT NULL,
	 firstname VARCHAR(25) NOT NULL,
	 lvl INT NOT NULL,
	 sortpath VARCHAR(892) NOT NULL ,
	 INDEX idx_lvl_empid_sortpath NONCLUSTERED(lvl, empid, sortpath)
)
WITH SCHEMABINDING
AS
BEGIN
 DECLARE @lvl AS INT = 0;
 -- insert subtree root node into @Tree
 INSERT INTO @Tree(empid, mgrid, firstname, lvl, sortpath)
        SELECT empid, NULL AS mgrid, firstname, @lvl AS lvl, '.' AS sortpath
          FROM HR.Employees
 WHERE empid = @mgrid;
 WHILE @@ROWCOUNT > 0 AND (@lvl < @maxlevels OR @maxlevels IS NULL)
 BEGIN
 SET @lvl += 1;
 -- insert children of nodes from prev level into @Tree
 INSERT INTO @Tree(empid, mgrid, firstname, lvl, sortpath)
		SELECT S.empid, S.mgrid, S.firstname, @lvl AS lvl, M.sortpath + CAST(S.empid AS VARCHAR(10)) + '.' AS sortpath
         FROM HR.Employees AS S
          INNER JOIN @Tree AS M ON S.mgrid = M.empid AND M.lvl = @lvl - 1;
 END;

 RETURN;
END;
GO
--utilizando
SELECT * FROM dbo.GetSubtree(3, null)


