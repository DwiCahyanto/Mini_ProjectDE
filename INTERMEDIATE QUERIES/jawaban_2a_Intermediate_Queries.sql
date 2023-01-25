-- Transform:Intermediate Queries
use Northwind;
--1
with order_month as(
select
OrderID,
Month(OrderDate) as month_order
from Orders
group by OrderDate,OrderID)

select
distinct month_order,
count(OrderID) over (partition by month_order) as total_transaksi
from order_month
group by month_order,OrderID
;

--No. 2
select 
FirstName,
LastName,
Title
from Employees
where Title='Sales Representative';

--No.3
select 
distinct OD.ProductID,
P.ProductName,
OD.OrderID,
count(OD.OrderID) over (partition by OD.ProductID) as n_order,
O.OrderDate
from [Order Details] as OD
inner join Orders as O
	on O.OrderID = OD.OrderID
inner join Products as P
	on OD.ProductID =  P.ProductID
Where OrderDate >= '1997-01-01' and OrderDate < '1997-02-01'
group by OD.ProductID, OD.OrderID, P.ProductName,O.OrderDate
order by n_order desc
;

--4
select
cs.CustomerID,
cs.CompanyName,
P.ProductName,
OD.ProductID,
OD.OrderID,
O.OrderDate
from [Order Details] as OD
inner join Orders as O
	on O.OrderID = OD.OrderID
inner join Products as P
	on OD.ProductID =  P.ProductID
inner join Customers as cs
	on O.CustomerID = cs.CustomerID
Where OrderDate >= '1997-06-01' and OrderDate < '1997-07-01' and OD.ProductID = 1;

--5
--below 100
with purchase as (
select 
distinct OrderID,
sum(UnitPrice * Quantity) as total_purchase
from [Order Details]
group by OrderID)

select 
OrderID,
total_purchase
from purchase
where total_purchase <= 100
;
--betwen 100 and 250
with purchase as (
select 
distinct OrderID,
sum(UnitPrice * Quantity) as total_purchase
from [Order Details]
group by OrderID)

select 
OrderID,
total_purchase
from purchase
where total_purchase > 100 and total_purchase <= 250
;
-- betwen 250 and 500
with purchase as (
select 
distinct OrderID,
sum(UnitPrice * Quantity) as total_purchase
from [Order Details]
group by OrderID)

select 
OrderID,
total_purchase
from purchase
where total_purchase > 250 and total_purchase <= 500
;
-- above 500
with purchase as (
select 
distinct OrderID,
sum(UnitPrice * Quantity) as total_purchase
from [Order Details]
group by OrderID)

select 
OrderID,
total_purchase
from purchase
where total_purchase > 500
;

--6
with purchase as (
select 
distinct OD.OrderID,
sum(UnitPrice * Quantity) as total_purchase
from [Order Details] as OD
group by OD.OrderID)

select 
P.OrderID,
O.OrderDate,
total_purchase
from purchase as P
join Orders as O
	on O.OrderID = P.OrderID
where total_purchase > 500 and YEAR(O.OrderDate) = '1997';

--7
with sales as (
select 
OD.ProductID,
OD.OrderID,
dense_rank() over (partition by MONTH(O.OrderDate) order by sum(UnitPrice * Quantity) desc) as top_sales,
sum(UnitPrice * Quantity) as total_purchase
from [Order Details] as OD
inner join Orders as O
	on O.OrderID = OD.OrderID
where year(O.OrderDate) = '1997' 
group by OD.ProductID,OD.OrderID,O.OrderDate)

select 
S.OrderID,
S.ProductID,
P.ProductName,
top_sales,
total_purchase,
MONTH(O.OrderDate) as bulan
from sales as S
inner join Orders as O
	on O.OrderID = S.OrderID
inner join Products as P
	on P.ProductID = S.ProductID
where year(O.OrderDate) = '1997' and top_sales <= 8
order by bulan, top_sales;

--8
go
create view product_sale as
select
OD.OrderID,
OD.ProductID,
P.ProductName,
OD.UnitPrice,
OD.Quantity,
OD.Discount,
(OD.UnitPrice * OD.Quantity * (1-OD.Discount)) as final_price
from [Order Details] as OD
inner join Products as P
	on P.ProductID = OD.ProductID;
go

select *
from product_sale;

--9
GO
CREATE PROCEDURE customer_shiping_Identification
AS
@CustomerID nvarchar(100)
select
C.CustomerID,
C.CompanyName,
O.OrderID,
O.OrderDate,
O.RequiredDate,
O.ShippedDate
from Orders as O
inner join Customers as C
	on O.CustomerID=C.CustomerID
where C.CustomerID = @CustomerID;
GO

exec customer_shiping_Identification @CustomerID = 'SUPRD';
