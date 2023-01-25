USE Northwind;

SELECT
	O.OrderID,
	PD.ProductID,
	CT.CategoryID,
	CS.CustomerID,
	CS.CompanyName					AS nama_customer,
	O.OrderDate						AS tanggal_pembelian,
	DATENAME(month,O.OrderDate)		AS bulan_pembelian,
	OD.UnitPrice * OD.Quantity		AS total_pembelian,
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
	Customers AS CS ON O.CustomerID = CS.CustomerID;