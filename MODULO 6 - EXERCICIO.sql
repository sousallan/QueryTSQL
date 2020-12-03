/*
 EXERCÍCIO
 1. O departamento de Marketing está trabalhando em uma nova campanha de marketing e solicitou 
 a nossa equipe um relatório. Segue abaixo o texto com as especificações (Não me pergunte o por quê de algumas
 delas). 
    "Desejamos um relatório de Pedidos no período de 01-07-2014 até 31-07-2014, ordenado de data mais antiga para a mais recente e que
	todos os clientes tenham a letra 'K' em qualquer parte do nome. 
	As colunas exibidas no relatório devem ser: As três primeiras letras do nome do país de origem do cliente em caixa alta, a Data do Pedido com o mês e o dia 
	(Obs: o mês	deve ser escrito por extenso e separado do dia por  uma '/') e o nome do cliente.

	Grato
	Equipe de Marketring"

 2. O departamento de vendas tem estranhado o tempo entre o pedido e a sua data de envio e por isso gostaria de um relatório no qual fosse mostrado
    A diferença entre as datas do pedido e a data do envio, a região e as três primeiras letras do país, em caixa alta, no qual será enviado o produto. 
	O relatório deve ser do período do ano de 2015 e deve exibir apenas para países que possuem uma região cadastrada. 
    
      
*/

SELECT 
   UPPER(SUBSTRING(C.country, 1, 3)) AS [País], 
   CONCAT(DATENAME(MONTH, orderdate), ' / ', DATEPART(DAY, orderdate)) AS [Data Pedido],
   C.contactname
FROM Sales.Orders O
INNER JOIN Sales.Customers C ON C.custid = O.custid
WHERE C.contactname like '%K%'
  AND O.orderdate BETWEEN '20140701' AND '20140731'
ORDER BY O.orderdate


SELECT UPPER(SUBSTRING(shipCountry, 1, 3)) AS [País], 
       O.shipregion AS [Região],
       DATEDIFF(DAY, orderdate, shippeddate) AS [Dias Para o Envio]
FROM Sales.Orders O 
WHERE orderdate BETWEEN '20150101' AND '20151231'
  AND shipregion IS NOT NULL
ORDER BY País

