--SELECT * FROM Sales.Vw_ExemploVWParticionada WHERE orderdate > '20150101'
CREATE VIEW Sales.Vw_ExemploVWParticionada
AS
SELECT orderid, 
        custid, 
		 empid, 
     orderdate, 
  requireddate, 
   shippeddate, 
     shipperid, 
	   freight, 
	  shipname, 
   shipaddress, 
      shipcity, 
	 shipregion,
	 shippostalcode,
	 shipcountry
FROM Sales.Orders
WHERE orderdate > '20150101'
UNION ALL
SELECT orderid, 
        custid, 
		 empid, 
     orderdate, 
  requireddate, 
   shippeddate, 
     shipperid, 
	   freight, 
	  shipname, 
   shipaddress, 
      shipcity, 
	 shipregion,
	 shippostalcode,
	 shipcountry
FROM Sales.OrdersBKP
WHERE orderdate < '20150101'

