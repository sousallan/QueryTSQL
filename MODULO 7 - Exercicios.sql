/*
1. Com base na estrutura fornecida abaixo, faça as seguintes ações: 
*/ 
   DROP TABLE IF EXISTS dbo.Tabela_1
   CREATE TABLE dbo.Tabela_1 
   (
	  Id       INT IDENTITY(1, 1),
	  Nome     VARCHAR(100) NOT NULL,
	  Telefone VARCHAR(10)  NOT NULL,
	  Versao   TINYINT      NOT NULL
   );
   GO
   INSERT INTO dbo.Tabela_1 VALUES ('Allan', '9199999999', 1);
   GO


   DROP TABLE IF EXISTS dbo.Tabela_2
   CREATE TABLE dbo.Tabela_2
   (
      Id        INT IDENTITY(1, 1),
	  Nome      VARCHAR(100) NOT NULL,
	  Telefone  VARCHAR(10)  NOT NULL,
	  Versao    TINYINT      NOT NULL
   );
   GO
   
   INSERT INTO dbo.Tabela_2 VALUES ('Allan', '9199991111', 1);
   GO

/*
    1.1. Dado o script de tabelas a serem criadas, após a execução e criação das tabelas insira os dados abaixo na Tabela_1
	     Id  | Nome              |  Telefone       | Versao
		  2    Malcher             919999-8888       1
		  3    Biatriz             918888-7777       1
		 10    Anne                991111-6666       1           <- O id obrigatoriamente deve ser 10. 
		 20    Odilon              815555-2222       1           <- O id obrigatoriamente deve ser 20.
*/


SET IDENTITY_INSERT dbo.Tabela_1 ON;
    INSERT INTO dbo.Tabela_1 (Id,      Nome,     Telefone, Versao) 
	                  VALUES ( 2, 'Malcher', '9199998888',      1)
					        ,( 3, 'Biatriz', '9188887777',      1)
							,(10,    'Anne', '9111116666',      1)
							,(20,  'Odilon', '8155552222',      1);
SET IDENTITY_INSERT dbo.Tabela_1 OFF;

/*
    1.2. A Tabela_2 está desatualizada, sendo assim faça um merge entre as duas tabelas a fim de 
	     manter a segunda tabela atualizada. Para os registros que já existirem na Tabela_2 incremente o valor 
		 da versao. 
*/
MERGE INTO dbo.Tabela_2 AS Destino
USING dbo.Tabela_1 AS Origem ON  (Destino.Id = Origem.Id)
WHEN NOT MATCHED THEN 
     INSERT (Nome, Telefone, Versao)
	 VALUES (Origem.Nome, Origem.Telefone, Origem.Versao)
WHEN MATCHED THEN
     UPDATE SET Destino.Nome = Origem.Nome
	           ,Destino.Telefone = Origem.Telefone
	           ,Destino.Versao +=  1;
GO

/*
	1.3. Delete da Tabela_2 o registro com o ID maior que 10. 
	     Crie uma tabela temporária com o intuito de avaliar o resultado do delete e insira nesta tabela os valores que forem deletados. 
		 Observe o resultado. 
*/
DECLARE @Delete_Hist TABLE (Id Int, Nome VARCHAR(100));

DELETE FROM dbo.Tabela_1 
OUTPUT deleted.Id, deleted.Nome INTO @Delete_Hist (id, Nome)
WHERE Id >= 10;

SELECT * FROM @Delete_Hist;
SELECT * FROM dbo.Tabela_1
GO
	     
/*
	1.4. Atualize na Tabela_1 a versão dos registros que estiverem diferença da Tabela_2.
*/

UPDATE T1 
   SET T1.Versao = T2.Versao
FROM dbo.Tabela_1 AS T1 
 INNER JOIN dbo.Tabela_2 T2 ON T1.Id = T2.Id;


SELECT * FROM dbo.Tabela_1
SELECT * FROM dbo.Tabela_2