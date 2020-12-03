-- Cursor

DECLARE @id INT;


DECLARE crs CURSOR FOR
                   SELECT orderid FROM Sales.Orders

OPEN crs
FETCH NEXT FROM crs
           INTO @id

WHILE @@FETCH_STATUS = 0
BEGIN

           PRINT @id

FETCH NEXT FROM crs
           INTO @id
END

CLOSE crs
DEALLOCATE crs;