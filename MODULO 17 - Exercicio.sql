/*
  O antigo Analista de Banco de Dados da empresa come�ou a constru��o de uma procedure para encapsular a inser��o de dados na tabela de clientes, por�m ele pediu demiss�o antes de concluir. 
  Ent�o estamos encaminhando essa solicita��o para voc�. Abaixo segue o script inicial da procedure e o que deve ser acrescentado. 
  - Incluir uma mensagem de erro personalizada indicando que ao realizar o insert os valores de Regi�o e C�digo Postal n�o podem ser nulos (ao mesmo tempo). O erro deve ter o c�digo 66000 e severidade 16.
  - Incluir na procedure o tratamento de erro para exibir a mensagem cadastrada, quando os parametros de Regi�o e C�digo Postal estiverem nulos. 
*/
CREATE OR ALTER PROCEDURE Sales.InsertCliente 
 @CompanyName  NVARCHAR(40)
,@ContactName  NVARCHAR(30)
,@ContactTitle NVARCHAR(30)
,@Address      NVARCHAR(60)
,@City         NVARCHAR(15)
,@Region       NVARCHAR(15) = NULL
,@Country      NVARCHAR(15)
,@PostalCode   NVARCHAR(10) = NULL
,@Phone        NVARCHAR(24)
,@Fax          NVARCHAR(24) = NULL
AS
BEGIN	  
		  INSERT INTO Sales.Customers (address,   city,  companyname,  contactname,  contacttitle,  country,  fax,  phone, postalcode)
		                       VALUES (@Address, @City, @CompanyName, @ContactName, @ContactTitle, @Country, @Fax, @Phone, @PostalCode)

END