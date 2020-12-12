SELECT 
       O.orderid AS IdPedido,
	   (SELECT C.contactname FROM Sales.Customers AS C WHERE O.custid = C.custid) AS NomeCliente,
	   (SELECT P.Productname FROM Production.Products AS P WHERE P.productid = OD.productid) AS NomeProduto,
	   (SELECT S.companyname FROM Production.Products AS P
                          INNER JOIN Production.Suppliers AS S ON P.supplierid = S.supplierid
						  WHERE P.productid = OD.productid) AS Fornecedor,
	   O.orderdate AS DataPedido,
	   OD.unitprice AS PrecoUnitario,
	   OD.qty AS Quantidade,
       SUM(OD.unitprice * OD.qty) OVER (PARTITION BY O.orderdate 
	                                    ORDER BY O.orderdate
										ROWS BETWEEN UNBOUNDED PRECEDING
										         AND CURRENT ROW) AS total_corrente,
	   SUM(OD.unitprice * OD.qty) OVER (PARTITION BY O.orderid) AS Total_Pedido, 
	   SUM(OD.unitprice * OD.qty) OVER () AS Total_Geral,
       DENSE_RANK() OVER (PARTITION BY O.Orderid
	                      ORDER BY UnitPrice * QTY ASC) AS RankValores
	   FROM Sales.Orders AS O INNER JOIN Sales.OrderDetails AS OD ON O.orderid = OD.orderid
ORDER BY O.orderid ASC