USE Northwind

SELECT 
	O.OrderID,
	O.OrderDate,
	CS.CustomerID,
	OD.Quantity*OD.UnitPrice As Monetory
FROM Orders AS O
INNER JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
INNer JOIN Customers AS CS ON CS.CustomerID = O.CustomerID
;