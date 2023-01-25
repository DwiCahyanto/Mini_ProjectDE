USE Northwind;

SELECT
	O.OrderID,
	PD.ProductID,
	CT.CategoryID,
	SP.SupplierID,
	SP.CompanyName					AS nama_supplier,
	PD.UnitsInStock					AS stock_barang,
	OD.UnitPrice * OD.Quantity		AS Amount,
	PD.ProductName					AS nama_produk,
	CT.CategoryName					AS kategori_produk
FROM 
	Orders AS O
INNER JOIN 
	[Order Details] AS OD ON OD.OrderID = O.OrderID
INNER JOIN
	Products AS PD ON PD.ProductID = OD.ProductID
INNER JOIN
	Categories AS CT ON CT.CategoryID = PD.CategoryID
INNER JOIN
	Suppliers AS SP ON PD.SupplierID = SP.SupplierID;