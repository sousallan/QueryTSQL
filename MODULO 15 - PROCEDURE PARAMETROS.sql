-- Descobrindo os parametros da procedure
SELECT OBJECT_NAME(object_id), * FROM sys.parameters

-- Retornando dados de uma stored procedure / Parametro de input
EXEC dbo.spu_Customers @custid = 5
WITH RESULT SETS
(
  (
    [Nome Cliente] VARCHAR(100)
  )
);

/*
 Passar uma tabela como parametro em uma procedure
*/
--1 Criar o tipo de dados tabela
--2 Declara uma variável do tipo tabela, usando o tipo customizado que foi criado anteriormente
--3 Inserir na variável de tabela criada
CREATE TYPE dbo.Clientes AS TABLE (Id INT);

DECLARE @Clientes AS Clientes;

INSERT INTO @Clientes VALUES (1), (2), (3), (4)

EXEC dbo.spu_ProcedureTableP @Clientes
GO
--4 CRIAÇÃO DA PROCEDURE QUE VAI RECEBER O PARAMETRO
CREATE OR ALTER PROCEDURE dbo.spu_ProcedureTableP
@Clientes Clientes READONLY -- Parametros do tipo tabela só podem ser somente leitura
AS 
 BEGIN
       SELECT * FROM Sales.Customers AS C CROSS APPLY (SELECT id FROM @Clientes AS Cv WHERE Cv.Id = C.custid) AS T
 END
GO
--

-- Utilizando Parametros de OUTPUT
CREATE OR ALTER PROCEDURE dbo.spu_OutputProc 
@Valor NUMERIC(18,2) = NULL OUTPUT
AS
 BEGIN
	 SELECT @Valor = SUM(unitprice * qty) FROM Sales.OrderDetails
 END
GO

DECLARE @ValorOUT NUMERIC(18,2)
EXEC dbo.spu_OutputProc @Valor = @ValorOUT OUTPUT
SELECT @ValorOUT AS VALOR_OUTPUT
--
GO
--RETORNAR CURSOR COMO PARAMETRO DE SAÍDA DE UMA PROCEDURE
CREATE OR ALTER PROCEDURE dbo.spu_cursorOUT 
@cursorOUT CURSOR VARYING OUTPUT
AS
  BEGIN
      SET @cursorOUT = CURSOR FOR SELECT custid, companyname FROM Sales.Customers
	  OPEN @cursorOUT;
  END
GO

-- Usar cursor como parametro de output
DECLARE @CursorOutV CURSOR,
        @Id         INT,
		@nome       VARCHAR(100)

EXEC dbo.spu_cursorOUT @cursorOUT = @CursorOutV OUTPUT

	FETCH NEXT FROM @CursorOutV
	           INTO @Id, @nome

    WHILE (@@FETCH_STATUS = 0)
	BEGIN

			PRINT 'Id: ' + CAST(@Id as VARCHAR(100))
			PRINT 'Nome: ' + @nome


	FETCH NEXT FROM @CursorOutV
	           INTO @Id, @nome
	END