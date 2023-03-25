-- Query1
SELECT BranchId, ProductId, Date,SUM(Quantity)
FROM sale
GROUP BY BranchId, ProductId, Date WITH ROLLUP;

-- Query2
SELECT BranchOrderId, BranchCustomerId, SUM(TotalCost)
FROM orders
where Date like '2022-%'
GROUP BY BranchOrderId, BranchCustomerId WITH ROLLUP;

-- Query3
select source.SupplierId, SupplyingBranchId, SuppliedProductId,
sum(SuppliedProductPrice*SuppliedProductQuantity) AS netPurchase from source,
suppliercatalog where source.SupplierId = suppliercatalog.SupplierId
group by source.SupplierId, SupplyingBranchId, SuppliedProductId WITH ROLLUP;

-- Query4
select customer_order_history.CustomerId, order_product_list.ProductId,
sum(ProductQuantity) as TotalProductQuantity 
from customer_order_history,
orders, order_product_list 
where orders.OrderId = order_product_list.OrderId
and customer_order_history.OrderId = order_product_list.OrderId 
group by customer_order_history.CustomerId,   order_product_list.ProductId;
