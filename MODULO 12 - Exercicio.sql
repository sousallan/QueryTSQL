/*
 EXERCÍCIO 
        1. O departamento de relacionamento com o cliente solicitou um relatório que pede as seguintes informações: 
          Nome do cliente, A Data da Ultima Compra e o Maior frete pago. 
*/
/*
  EXECUTE OS SCRIPTS ABAIXO PARA REALIZAR O ITEM 2.
*/
		 --Apaga a tabela de backup caso já exista.
		DROP TABLE IF EXISTS Sales.OrdersBKP
		DROP TABLE IF EXISTS Sales.OrderDetailsBKP
		--insere os dados da tabela de pedidos, criando a tabela de backup
		SELECT * INTO Sales.OrdersBKP FROM Sales.Orders
		SELECT * INTO Sales.OrderDetailsBKP FROM Sales.OrderDetails
		-- deleta os registros anteriores a 2015. 
		DELETE FROM Sales.OrderDetails WHERE orderid IN (SELECT orderid FROM Sales.Orders WHERE orderdate < '20150101')
		DELETE FROM Sales.Orders WHERE orderdate < '20150101'

/*
  
  2. Devido a problemas de espaço em disco no servidor, os registros de vendas de datas anteriores a 2015 foram movidas para uma tabela 
     de backup. Mas o departamento de vendas ainda precisa analisar as vendas que ocorreram naquele ano. Dessa forma foi solicitado a você 
     a construção de um relatório. 
     2.1 Um relatório que faça a união novamente entre os registros atuais e os históricos com as informações de: 
         orderid, custid, orderdate, productid, unitprice, qty e discount;
*/





