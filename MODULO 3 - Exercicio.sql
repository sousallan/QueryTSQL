--1. Disponibilize para o Departamento de Marketing uma lista com todos os clientes (tabela: Sales.Customers) para que eles possam gerar uma campanha de marketing;
--Após receber a sua lista com todos os clientes, o Marketing gostaria de saber, também, o país de origem dos clientes. Lembre-se de eliminar os registros duplicados;
--O Marketing recebeu a sua listagem inicial, porém gostaria de um ajuste com o nome de colunas mais amigáveis e, que fosse enviada também uma listagem de todos os produtos da empresa (tabela: Production.Products);
--O Marketing retornou a sua listagem com mais uma solicitação. Como a empresa possui uma listagem muito grande de produtos, eles gostariam que fosse incluída a informação de categoria dos produtos e por isso nos enviaram um mapeamento das categorias com o seu id e nome. Segue abaixo: 
--ID: 1 – Bebidas
--ID: 2 – Condimentos
--ID: 3 – Confeitaria
--ID: 4 – Produtos Lácteos 
--ID: 5 – Grãos e Cereais
--ID: 6 – Carnes
--ID: 7 – Frutas
--ID: 8 – Alimentos do Mar

-- 1.
   SELECT * FROM Sales.Customers;
-- 1.2
   SELECT DISTINCT country FROM Sales.Customers;
-- 1.3
   SELECT companyname AS [Nome Companhia], contactname AS [Nome Cliente], contacttitle AS [Cargo], address AS [Endereço], city, region, country, phone, fax 
   FROM Sales.Customers;

   SELECT 
        categoryid AS ID, 
        CASE categoryid
		   WHEN 1 THEN 'Bebidas'
		   WHEN 2 THEN 'Condimentos'
		   WHEN 3 THEN 'Confeitaria'
		   WHEN 4 THEN 'Produtos Lácteos'
		   WHEN 5 THEN 'Grãos e Cereais'
		   WHEN 6 THEN 'Carnes'
		   WHEN 7 THEN 'Frutas'
		   WHEN 8 THEN 'Alimentos do Mar'
		ELSE 'N/A' END AS Categoria,
		supplierid, unitprice, discontinued
   FROM Production.Products;


SELECT * FROM Sales.OrderDetails AS OD
WHERE OD.productid = 1

