/*
  1. O gerente de vendas solicitou para você um relatório onde ele possa visualizar o total das vendas agrupados por data, o valor total das vendas seja superior a 2000.00 e a quantidade de vendas
  na data.
  (necessário fazer um INNER JOIN entre as tabelas Sales.Ordes e Sales.OrderDetails
*/

SELECT orderdate, SUM(unitprice * qty) AS Total_Venda, COUNT(O.orderid) AS Quantidade_Venda
  FROM Sales.Orders O INNER JOIN Sales.OrderDetails OD ON O.orderid = OD.orderid
GROUP BY orderdate
HAVING SUM(unitprice * qty) >= 2000.00
ORDER BY orderdate, Total_Venda