/*
1: Reescreva o script montado no módulo anterior, e ao invés de utilizar a Expressão case para exibir as categorias dos produtos faça um INNER JOIN entre as tabelas de Categoria (Production.Categories) e Produto (Production.Products)

2: O departamento de vendas gostaria de um relatório de todos os clientes que fizeram pelo menos um pedido, com as informações detalhadas de cada um. (Sales.Customer, Sales.Orders, Sales.OrderDetails)

3: O departamento de RH gostaria de um relatório na qual fosse exibido os colaboradores e seus gerentes. Mostrando os campos Lastname, Firstname e Title tanto para os empregados quanto para os gerentes. 

*/

-- Exercício 1
SELECT 
   P.productname, 
   P.categoryId, 
   C.categoryname, 
   C.description
FROM Production.Products P INNER JOIN Production.Categories C ON C.categoryid = P.categoryId

--Exercício 2
SELECT * FROM Sales.Customers C 
          INNER JOIN Sales.Orders O ON C.custid = O.custid
		  INNER JOIN Sales.OrderDetails OD ON OD.orderid = O.orderid;

--Exercício 3
SELECT  e.lastname, e.firstname, 
	    e.title, 
		m.lastname,
		m.firstname,
		m.title
FROM HR.Employees AS e LEFT OUTER JOIN HR.Employees AS m
ON e.mgrid=m.empid;
