--Revenue total, product revenue y shipping revenue
SELECT 
SUM(price) AS total_product_revenue,
SUM(freight_value) AS total_shipping_revenue,
SUM(price + freight_value) AS total_revenue
FROM order_items

--Ventas por mes (ingresos)
SELECT 
YEAR(order_purchase_timestamp) AS year,
MONTH(order_purchase_timestamp) AS month,
SUM(oi.price + oi.freight_value) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY 
YEAR(order_purchase_timestamp),
MONTH(order_purchase_timestamp)
ORDER BY year, month

--Top 10 productos mas vendidos (los que tienen mas ventas)
SELECT
TOP 10
Name_eng as product_category,
COUNT(oi.order_id) AS total_sold
FROM Products p
JOIN Order_items oi
ON p.product_id = oi.product_id
JOIN Category_name_translation c
ON c.Name_bra = product_category_name
GROUP BY Name_eng
ORDER BY total_sold DESC

--Top vendedores (sellers)
SELECT
TOP 10
seller_id,
SUM(price) AS revenue
FROM order_items
GROUP BY seller_id
ORDER BY revenue DESC

--

--Numero total de pedidos entregados
SELECT 
order_status,
COUNT(*) AS total
FROM Orders
GROUP BY order_status

--Estados con mas ventas (ingresos)
SELECT 
c.customer_state,
SUM(oi.price) AS revenue
FROM orders o
JOIN customers c 
ON o.customer_id = c.customer_id
JOIN order_items oi 
ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC;

--Ventas por estado (en que estados hubo mas pedidos)
SELECT 
c.customer_state,
COUNT(o.order_id) AS total_orders
FROM Orders o
JOIN Customers c 
ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC

--Ticket promedio por pedido
SELECT 
AVG(order_value) AS avg_order_value
FROM (
SELECT 
order_id,
SUM(price + freight_value) AS order_value
FROM order_items
GROUP BY order_id
) t

--Categorias que generan mas ingresos
SELECT
Name_eng AS Category,
SUM(price)
FROM Products p
JOIN Order_items o
ON p.product_id = o.product_id
JOIN Category_name_translation cnt
ON p.product_category_name = cnt.Name_bra
GROUP BY Name_eng



