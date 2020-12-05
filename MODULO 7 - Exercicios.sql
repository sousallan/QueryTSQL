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

    1.2. A Tabela_2 está desatualizada, sendo assim faça um merge entre as duas tabelas a fim de 
	     manter a segunda tabela atualizada. Para os registros que já existirem na Tabela_2 incremente o valor 
		 da versao. 

	1.3. Delete da Tabela_2 o registro com o ID maior que 10. 
	     Crie uma tabela temporária com o intuito de avaliar o resultado do delete e insira nesta tabela os valores que forem deletados. 
		 Observe o resultado. 
	     

	1.4. Atualize na Tabela_1 a versão dos registros que estiverem diferença da Tabela_2 e delete os registros com o ID maior ou igual a 10.
*/