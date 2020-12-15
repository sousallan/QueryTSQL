/*
  O antigo Analista de Banco de Dados da empresa começou a construção de uma procedure para encapsular a inserção de dados na tabela de clientes, porém ele pediu demissão antes de concluir. 
  Então estamos encaminhando essa solicitação para você. Abaixo segue o script inicial da procedure e o que deve ser acrescentado. 
  - Incluir uma mensagem de erro personalizada indicando que ao realizar o insert os valores de Região e Código Postal não podem ser nulos (ao mesmo tempo). O erro deve ter o código 66000 e severidade 16.
  - Incluir na procedure o tratamento de erro para exibir a mensagem cadastrada, quando os parametros de Região e Código Postal estiverem nulos. 
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