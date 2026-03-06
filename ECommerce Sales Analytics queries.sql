USE store;

-- 1. - Top selling products
SELECT p.product_name,
SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- 2. -- Revenue by product
SELECT p.product_name,
SUM(oi.quantity * p.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

-- 3. -- Top 5 Customers by Spending
SELECT c.name,
SUM(p.amount) AS spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.name
ORDER BY spent DESC
LIMIT 5;

-- 4. -- Revenue from delivered orders
SELECT p.product_name,
SUM(oi.quantity * p.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_name
ORDER BY revenue DESC;

-- 5. --Products That Never Sold.
 SELECT p.product_id , p.product_name , oi.quantity
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

-- 6. Most Orders Per Customer
SELECT c.name,
COUNT(o.order_id) AS orders_given
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.name
ORDER BY orders_given DESC;

-- 7. -- Cancelled Orders Count
SELECT COUNT(*) AS cancelled_orders
FROM orders
WHERE order_status = 'Cancelled';

-- 8. -- Revenue by Customer
SELECT c.name,
SUM(p.amount) AS revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.name
ORDER BY revenue DESC;

--  9. -- Total Revenue
SELECT SUM(amount) AS revenue
FROM payments;
