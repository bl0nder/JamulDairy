select * from vehicle where Brand = 'in';
-- AggregateQueries
select MAX(Unit_price) from product where Id LIKE 'P01%';
select MIN(Unit_price) from product where Id LIKE 'P01%';
select count(*) from vehicle where Brand = 'in' or Brand = 'aut';
select SUM(Unit_price) from product;
-- OrderBy
select * from source order by Date;
-- Between
select * from source where Date between '2000-01-01' and '2005-12-31' order by Date desc;
--Update
update suppliercatalog set SuppliedProductPrice = 1000 where SupplierId = 'S010378';
-- AND/Or
select * from orders where (BranchOrderId LIKE 'B5%' OR BranchOrderId LIKE'B6%') and BranchCustomerId LIKE 'C29%';
-- Delete
delete from vehicle where Brand = 'in';
--Join
SELECT orders.OrderID, orders.BranchCustomerId as 'CustomerId', order_product_list.ProductId,
order_product_list.ProductName, order_product_list.ProductQuantity 
FROM orders
INNER JOIN order_product_list ON Orders.OrderId = order_product_list.OrderId order by CustomerId;
-- GroupBy
SELECT COUNT(DriverId), VehicleBranchId
FROM vehicle
GROUP BY VehicleBranchId;
--NestedQuery
select * from (select customer.CustomerId, customer.Birthday ,customer.Name, 
customer.ContactNum, add_to_cart.TotalCost
FROM customer
INNER JOIN add_to_cart ON customer.CustomerId = add_to_cart.CustomerId) 
as T where TotalCost in (select MAX(TotalCost) from add_to_cart);
-- Division Query
select CustomerId, Name 
from customer 
where NOT exists
(select ProductId from cart_items where
 ProductId in (Select ProductId from cart_items where CustomerId = 'C000995') and 
 ProductId not in (Select ProductId from cart_items, customer where (customer.CustomerId = cart_items.CustomerId)));
 
