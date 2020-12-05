USE TSQLV4
GO

--SELECT * FROM Stats.Scores

IF 60 >= ALL (SELECT score FROM Stats.Scores)
	BEGIN 
	   PRINT 'Todos as pontuações são menores do que 60';
	END
ELSE
    BEGIN
	   PRINT 'Nem todas as pontuações são menores do que 60';
	END
--
-- ANY -> SQL ANSI
IF 60 >= SOME (SELECT score FROM Stats.Scores)
	BEGIN 
	   PRINT 'Existem pontuações menores do que 60';
	END
ELSE
    BEGIN
	   PRINT 'Não existem pontuações menores do que 60';
	END
--

SELECT * FROM Sales.OrderDetails
where unitprice <= ANY  (SELECT unitprice FROM Production.Products WHERE unitprice <= 10)

SELECT * FROM Sales.OrderDetails
where NOT unitprice <= SOME  (SELECT unitprice FROM Production.Products WHERE unitprice <= 10)

SELECT * FROM Sales.OrderDetails
where unitprice > ALL  (SELECT unitprice FROM Production.Products WHERE unitprice <= 10)

