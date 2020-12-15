--O Departamento de vendas solicitou para a equipe de TI, um relatório no qual seja mostrado o 
--total agrupado por Cidade, Região e País de forma hierárquica;

--O Departamento de Estoque e Logística solicitou que fosse criada uma visão para eles, 
--na qual mostrasse a quantidade de produtos vendidos por ano. Os anos devem ser mostrados em colunas, 
--e nas linhas os nomes dos produtos e o valor de contagem dos produtos. 

--1 
SELECT shipcountry, shipregion, shipcity, sum(unitprice * qty) as total FROM Sales.Orders AS O
                                         INNER JOIN Sales.OrderDetails AS OD ON O.orderid = OD.orderid
WHERE shipregion IS NOT NULL
GROUP BY ROLLUP (shipcountry, shipregion, shipcity);

GO
CREATE OR ALTER VIEW Vw_ViewProdutosPorAno
WITH SCHEMABINDING
AS
SELECT productname, [2014], [2015], [2016] FROM 
(SELECT P.productname, YEAR(orderdate) AS Ano, P.productid 
                                      FROM Sales.Orders as O
                                            INNER JOIN Sales.OrderDetails AS OD ON O.orderid = OD.orderid
											INNER JOIN Production.Products AS P ON P.productid = OD.productid) AS T
PIVOT (
       COUNT(productid) 
	   FOR Ano IN ([2014],[2015], [2016])) AS Pvt
--
GO
SELECT * FROM Vw_ViewProdutosPorAno

