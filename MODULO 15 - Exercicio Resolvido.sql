/*
Crie uma procedure que faça um backup da tabela de produtos;
Crie uma procedure que faça a atualização de valor do produto de acordo com o código do produto passado como parâmetro, para os produtos que não estão descontinuados
*/

--1
CREATE OR ALTER PROCEDURE dbo.spu_BKPProdutos
AS 
BEGIN
      DROP TABLE dbo.BKP_PRODUTOS
      SELECT * INTO dbo.BKP_PRODUTOS FROM Production.Products;
END
--
GO
EXEC dbo.spu_BKPProdutos
SELECT * FROM dbo.BKP_PRODUTOS
GO

--2
CREATE OR ALTER PROCEDURE dbo.spu_AtualizarProduto
 @CodigoProduto INT
,@NovoValor     MONEY
AS 
 BEGIN
     UPDATE dbo.BKP_PRODUTOS
	    SET unitprice = @NovoValor
	 OUTPUT deleted.unitprice 
	 WHERE productid = @CodigoProduto
 END
GO

EXEC dbo.spu_AtualizarProduto @CodigoProduto = 1, @NovoValor = 200.00 