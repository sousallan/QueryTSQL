DECLARE @id INT = 10400,
        @Sql VARCHAR(MAX) = ''

SET @Sql = CONCAT('SELECT * FROM Sales.Orders WHERE Orderid = ', @id)

EXEC (@Sql);
EXEC ('SELECT * FROM Sales.Orders WHERE Orderid = ' + @id)


---
DECLARE @SQLString        NVARCHAR(500);  
DECLARE @Parametros       NVARCHAR(500);  
DECLARE @ValorMaximo      NVARCHAR(25);  
DECLARE @OrderId          INT;  
SET @SQLString = N'SELECT @ValorOUT = MAX((unitprice * qty)) FROM Sales.OrderDetails WHERE orderid = @OrderIdIn';  

SET @Parametros = N'@OrderIdIn INT,  
                    @ValorOUT NVARCHAR(25) OUTPUT';  
SET @OrderId = 10400;  
EXECUTE sp_executesql  
     @SQLString  
    ,@Parametros  
    ,@OrderIdIn = @OrderId  
    ,@ValorOUT = @ValorMaximo OUTPUT; 
	
SELECT @ValorMaximo;  



