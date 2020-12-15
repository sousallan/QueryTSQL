USE TSQLV4
GO
/*
pivot dinâmico
*/

DECLARE @vSQL VARCHAR(MAX) = '';
DECLARE @SQLString        NVARCHAR(500);  
DECLARE @Parametros       NVARCHAR(500);  

SELECT @vSQL = @vSQL + '['+ Tabela.Coluna + '], ' FROM (SELECT DISTINCT shipcountry AS Coluna FROM Sales.Orders) AS Tabela
SET @vSQL = LEFT(@vSQL, LEN(@vSQL)-1);

 
SET @SQLString = N'SELECT * FROM
					(SELECT YEAR(orderdate) AS Ano , shipcountry, orderid FROM Sales.Orders ) AS Tbl
					PIVOT 
						 (
						   COUNT(orderid)  
						   FOR shipcountry IN ('+ @vSQL +')
						 ) AS Pvt';  

EXECUTE sp_executesql  @SQLString  

	 



