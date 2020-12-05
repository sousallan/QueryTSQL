use tsqlv4;
go

/*
   1. Aproveitando o script criado para o exercício do módulo anterior. Acrescente uma coluna avaliando o tempo para envio de um produto. 
      Se o tempo de envio for maior do que 10 então exiba 'Muito Demorado' senão 'Dentro do Prazo'. 

   2. Ajuste o Script para que seja retornado os registros em que a região não tenha um valor (seja null), e nesses casos substitua o valor NULL por "Região Não informada")
*/

SELECT UPPER(SUBSTRING(shipCountry, 1, 3)) AS [País], 
       COALESCE(shipregion, 'Sem Região Cadastrada') AS [Região],
       DATEDIFF(DAY, orderdate, shippeddate) AS [Dias Para o Envio],
	   IIF(DATEDIFF(DAY, orderdate, shippeddate) > 10, 'Muito Demorado', 'Dentro do Prazo')
FROM Sales.Orders O 
WHERE orderdate BETWEEN '20150101' AND '20151231'
ORDER BY País

