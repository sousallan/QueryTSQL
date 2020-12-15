USE master;
GO

CREATE DATABASE CLR_DataBase;
GO
USE CLR_DataBase;
GO


EXEC sp_configure 'clr enabled', 1
GO
RECONFIGURE
GO

CREATE ASSEMBLY CLRProject
FROM 'C:\Temp\CLRProject.dll'
WITH PERMISSION_SET = SAFE
GO

CREATE PROCEDURE usp_CLRProject
AS 
EXTERNAL NAME CLRProject.[CLRProject.StoredProcedures].ClrProject
GO

EXEC usp_CLRProject;
--
GO
CREATE FUNCTION udf_CountClr(@parametro1 int, @parametro2 int) RETURNS INT   
AS EXTERNAL NAME CLRProject.[CLRProject.ScalarFunctions].ReturnSoma;
GO  

DECLARE @par1 INT = 10, @par2 INT = 20
SELECT dbo.udf_CountClr(@par1, @par2);

