CREATE OR ALTER PROCEDURE Sales.Procedure2
AS
BEGIN
    DECLARE @TEXTO VARCHAR(10) = ''
	SET @TEXTO = 'AHBNCPJ';

	DECLARE @DescricaoErro VARCHAR(1000) = ''
	       ,@ProcedureName VARCHAR(1000) = ''
		   ,@NumeroErro    INT
		   ,@ErroFormatado VARCHAR(1000) = ''

	BEGIN TRY 
		SELECT CAST(@TEXTO AS INT);
	END TRY
	BEGIN CATCH
	    SELECT @ProcedureName = ERROR_PROCEDURE()
		      ,@DescricaoErro = ERROR_MESSAGE()
			  ,@NumeroErro    =	ERROR_NUMBER()
	    
		SELECT @ErroFormatado = FORMATMESSAGE('Erro customizado. Procedure: %s. Numero do Erro: %i. Descrição Erro: %s.', @ProcedureName, @NumeroErro, @DescricaoErro);
		THROW 50000, @ErroFormatado, 1;

	END CATCH
END
GO

CREATE OR ALTER PROCEDURE Sales.Procedure1
AS
BEGIN
	BEGIN TRY
		  SELECT 'A'
	END TRY
	BEGIN CATCH
	      THROW 50001, 'Erro Proc 1', 1;
	END CATCH

	EXEC Sales.Procedure2;
END
GO


EXEC Sales.Procedure1;


