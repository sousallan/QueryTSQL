/*
Artigo de conversão de dados
https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver15
*/

--Conversão
--CAST / CONVERT / PARSE

DECLARE @Numero INT = 10
DECLARE @NumeroMaior NUMERIC(18,2) = 10.02
DECLARE @Data   DATETIME = '20201231 23:59:59'
DECLARE @DataV  VARCHAR(08) = '20201131'

SELECT CAST(@Numero AS NUMERIC(10,2)) 
SELECT @Numero = @NumeroMaior
SELECT CAST(@NumeroMaior AS SMALLINT)

SELECT CONVERT(DATE, @Data, 112)

SELECT PARSE('Monday, 13 December 2010' AS datetime2 USING 'en-US') AS Result; 

SET LANGUAGE 'English';  
SELECT PARSE('12/16/2010' AS datetime2) AS Result; 


---
--- TRY_CAST, TRY_CONVERT, TRY_PARSE
SELECT TRY_CAST('ABC' AS INT) -- CONVERT
SELECT TRY_PARSE(@DataV AS date USING 'en-US')
