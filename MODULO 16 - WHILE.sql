DECLARE @contador INT = 1


WHILE (@contador < 100) 
BEGIN
    SET @contador = @contador + 1;
	PRINT @contador

	IF @contador = 50
	   BREAK;
	ELSE
	   CONTINUE;
	
END
---
