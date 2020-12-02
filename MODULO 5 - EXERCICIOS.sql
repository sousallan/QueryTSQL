/*
O Departamento de Marketing está trabalhando em novas campanhas de divulgação, e precisar de informações para melhora-las. Com isso foi solicitado a você a construção de um relatório 
com as seguintes informações: As vendas realizadas no último trimestre de 2014 (Out – Dez) com os campos: País, Cidade, Data do Pedido, Total da Compra (UnitPrice * Qty) sem considerar o desconto. 

Após você entregar o relatório para o Departamento de Marketing, foi detectado a necessidade de visualizar os dados de forma ordenada: Do maior valor total para o menor valor total (Descendente)

O Departamento de Vendas, também, solicitou a você um relatório com os últimos pedidos realizados com o top 10% dos produtos mais caros sendo vendidos

Lembra do relatório para a equipe de Marketing? Então... Como a listagem é muito longa foi solicitando a inclusão de uma paginação na consulta, na qual deverá permitir a exibição de 20 linhas por página. 
*/
--1, 2
SELECT O.shipcountry AS [País], O.shipcity AS [Cidade], O.orderdate as [Data Pedido], (OD.unitprice * od.qty) AS [Total da Compra] 
FROM Sales.Orders AS O INNER JOIN Sales.OrderDetails AS OD ON O.orderid = OD.orderid
WHERE O.orderdate >= '20141001' AND O.orderdate < '20150101'
ORDER BY [Total da Compra] DESC;

--3
SELECT TOP(10) PERCENT WITH TIES * FROM Sales.Orders AS O INNER JOIN
              Sales.OrderDetails AS OD ON O.orderid = OD.orderid INNER JOIN 
              Production.Products AS P ON P.productid = OD.productid
ORDER BY P.unitprice DESC, O.orderdate DESC


--4
DECLARE @pagenum  AS BIGINT = 1
       ,@pagesize AS BIGINT = 20

SELECT O.shipcountry AS [País], O.shipcity AS [Cidade], O.orderdate as [Data Pedido], (OD.unitprice * od.qty) AS [Total da Compra] FROM Sales.Orders AS O INNER JOIN Sales.OrderDetails AS OD ON O.orderid = OD.orderid
WHERE O.orderdate >= '20141001' AND O.orderdate < '20150101'
ORDER BY [Total da Compra] DESC
OFFSET (@pagenum - 1) * @pagesize ROW FETCH FIRST @pagesize ROW ONLY;

