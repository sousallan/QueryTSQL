CREATE TABLE Sales.Identidade 
(
   ID INT IDENTITY(10, 100),
   TEXTO CHAR(01) NULL
);

INSERT INTO Sales.Identidade VALUES (NULL);

SELECT * FROM Sales.Identidade;

--DROP TABLE Sales.Identidade;
--TRUNCATE TABLE Sales.Identidade;
--DELETE FROM Sales.Identidade;

GO
---
--IDENTITY(1, 1)
CREATE SEQUENCE Sales.SequenceExemplo -- usa cache
 AS INT
 START WITH 1
 INCREMENT BY 1
 MINVALUE 1   -- pode ser setado um valor mínimo
 MAXVALUE 3;  -- e um valor máximo, e então a sequence reinicia
GO

CREATE TABLE Sales.TabelaSequence
 (
  ID int PRIMARY KEY,
  NOME varchar(25) NOT NULL
  );
GO 

CREATE TABLE Sales.TabelaSequence2
(
  ID INT PRIMARY KEY,
  NOME VARCHAR(25) NOT NULL
);

INSERT INTO Sales.TabelaSequence (ID,NOME) VALUES (NEXT VALUE FOR Sales.SequenceExemplo, 'NOME'); 
INSERT INTO Sales.TabelaSequence2 (ID,NOME) VALUES (NEXT VALUE FOR Sales.SequenceExemplo, 'NOME');

SELECT * FROM Sales.TabelaSequence;
SELECT * FROM Sales.TabelaSequence2;


--TRUNCATE TABLE Sales.TabelaSequence;
DROP TABLE Sales.TabelaSequence;
DROP TABLE Sales.TabelaSequence2;