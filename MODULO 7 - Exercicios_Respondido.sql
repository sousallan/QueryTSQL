SET IDENTITY_INSERT dbo.Tabela_1 ON;
    INSERT INTO dbo.Tabela_1 (Id,      Nome,     Telefone, Versao) 
	                  VALUES ( 2, 'Malcher', '9199998888',      1)
					        ,( 3, 'Biatriz', '9188887777',      1)
							,(10,    'Anne', '9111116666',      1)
							,(20,  'Odilon', '8155552222',      1);
SET IDENTITY_INSERT dbo.Tabela_2 OFF;
GO


MERGE INTO dbo.Tabela_2 AS Destino
USING dbo.Tabela_1 AS Origem ON  (Destino.Id = Origem.Id)
WHEN NOT MATCHED THEN 
     INSERT (Nome, Telefone, Versao)
	 VALUES (Origem.Nome, Origem.Telefone, Origem.Versao)
WHEN MATCHED THEN
     UPDATE SET Destino.Nome = Origem.Nome
	           ,Destino.Telefone = Origem.Telefone
	           ,Destino.Versao += 1;
GO

DECLARE @Delete_Hist TABLE (Id Int, Nome VARCHAR(100));

DELETE FROM dbo.Tabela_1 
OUTPUT deleted.Id, deleted.Nome INTO @Delete_Hist (id, Nome)
WHERE Id >= 10;

SELECT * FROM @Delete_Hist;
SELECT * FROM dbo.Tabela_1
GO

UPDATE T1 
   SET T1.Versao = T2.Versao
FROM dbo.Tabela_1 AS T1 
 INNER JOIN dbo.Tabela_2 T2 ON T1.Id = T2.Id;
GO
