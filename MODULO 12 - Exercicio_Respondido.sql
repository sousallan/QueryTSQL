SELECT C.contactname, Tabl.Ultima_Compra, Tabl.Maior_Frete_Pago FROM Sales.Customers AS C
         CROSS APPLY (SELECT max(O.orderdate) AS Ultima_Compra,
							 max(O.freight)   AS Maior_Frete_Pago
		              FROM Sales.Orders AS O
		              WHERE O.custid = C.custid
					  ) AS Tabl
 
SELECT O.orderid, 
       o.custid,
       orderdate, 
	   productid,
	   unitprice, 
	   qty,
	   discount
	   FROM Sales.Orders AS O INNER JOIN Sales.OrderDetails OD ON O.orderid = OD.orderid 
	   WHERE orderdate > '20150101'

UNION 

SELECT O.orderid, 
       o.custid,
       orderdate, 
	   productid,
	   unitprice, 
	   qty,
	   discount
	   FROM Sales.OrdersBKP AS O INNER JOIN Sales.OrderDetailsBKP OD ON O.orderid = OD.orderid 
	   WHERE orderdate < '20150101'


