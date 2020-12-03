use TSQLV4
go

-- Nomes com a letra 'a' em qualquer posição
SELECT contactname FROM sales.Customers WHERE contactname LIKE '%a%'
-- Nomes que começam com a letra 'a'
SELECT contactname FROM sales.Customers WHERE contactname LIKE 'a%'

CREATE TABLE #tmp
(
  nome varchar(100)
);
INSERT INTO #tmp VALUES ('Dean'), ('Sean'), ('Pean'), ('10%'), ('20%');
INSERT INTO #tmp VALUES ('10')

-- Um único caractere
SELECT nome FROM #tmp WHERE nome LIKE '_ean'
-- intervalo de caracteres
SELECT nome FROM #tmp WHERE nome LIKE '[D-P]ean' -- OU [DP]ean
-- valor que não esteja no intervalo de caracteres
SELECT nome FROM #tmp WHERE nome LIKE '[^D-P]ean'
-- Usando o SCAPE
SELECT nome FROM #tmp WHERE nome LIKE '%10!%' ESCAPE '!'


DECLARE @Tempo TIME = '11:20'


USE TSQLV4;
GO

/*
Suponhamos que você é americano e deseja consultar a tabela de pedidos (Sales.Orders) e que 
retorne os pedidos feitos em 02/12/2014 (Data em formato americano) e então faz o seguinte:
*/

SELECT orderid, orderdate
FROM Sales.Orders 
WHERE orderdate = '20140212'

/*
   Para você que é Americano isso significa Fevereiro 12, 2014. Mas se você fosse Britânico isso
   seria Dezembro 02, 2014 e se você fosse Japonês isso provavelmente seria Dezembro 14, 2002. 
*/

--'YYYYMMDD'


DECLARE @Data DATETIME = '20201001 12:59'

SELECT @Data

CREATE TABLE #TMP2 (DataCol DATETIME);

INSERT #tmp2 values (@Data);
INSERT #TMP2 VALUES ('20201001 23:59:59')


SELECT * FROM #TMP2
WHERE DataCol >= '20201001' AND DataCOL < '20201002'

SELECT * FROM #TMP2
WHERE DataCol between '20201001' AND '20201002'

/*
Obter a data e hora do sistema
GETDATE (CURRENT_TIMESTAMP, ANSI), GETUTCDATE, SYSDATETIME
Obter partes da DATE e HORA
DATENAME, DATEPART
Obter Data e Hora a partir de suas partes
DATETIME2FROMPARTS, DATEFROMPARTS
Obter a diferença entre Datas ou Horas
DATEDIFF, DATEDIFF_BIG
Para modificar o valor de uma Data ou Hora
DATEADD, EOMONTH
Para validar o valor de Data ou Hora
ISDATE
*/

SELECT GETDATE(), SYSDATETIME(), CURRENT_TIMESTAMP, GETUTCDATE()

SELECT DATENAME(MONTH, '20201001')
SELECT DATEPART(YEAR, '20201001') -- SELECT YEAR('20201001')
SELECT DATEFROMPARTS('2020','01','30')

SELECT DATEDIFF(DAY,'20201001','20201031')
go

DECLARE @data DATE = '20201001';
SELECT @data
SELECT DATEADD(DAY,5,@data);

SELECT EOMONTH('20201001');

SELECT ISDATE('20201201');
