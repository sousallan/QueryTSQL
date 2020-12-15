--GOTO / RETURN
DECLARE @bool BIT =  1

IF @bool = 0
BEGIN 
   GOTO PROXIMO
END

   SELECT 'A'
   SELECT 'B'
   RETURN  -- NESSE CONTEXTO NÃO PODEMOS UTILIZAR VALOR 

PROXIMO:
   IF 1 = 1 
      PRINT 'GOTO ME MANDOU AQUI'

--
GO
CREATE OR ALTER PROCEDURE dbo.spu_returnCode 
AS 
  SELECT * FROM TSQLV4.Sales.Orders;
  RETURN 1
GO

DECLARE @intRetCode INT;

EXEC @intRetCode = dbo.spu_returnCode

SELECT @intRetCode
