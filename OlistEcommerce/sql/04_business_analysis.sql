 USE OlistEcommerce;


-- кількість замовлень, клієнтів та продавців у системі:
SELECT COUNT(*) AS orders_count FROM orders;

SELECT COUNT(*) AS customers_count FROM customers;

SELECT COUNT(*) AS sellers_count FROM sellers;



-- Calculate total revenue
SELECT SUM(oi.price) as total_revenue
FROM order_items AS oi
INNER JOIN orders ON oi.order_id=orders.order_id
WHERE orders.order_status = 'delivered'; -- враховуємо тільки доставлені (гарантовано отримані гроші)



-- top 10 categories with most revenue
SELECT TOP 10 
	ct.product_category_name_english AS category_name,
	p.product_category_name AS original_name, 
	SUM(oi.price) AS total_sum
FROM products p 
JOIN order_items oi ON p.product_id=oi.product_id
LEFT JOIN category_translation ct ON p.product_category_name=ct.product_category_name
GROUP BY p.product_category_name, ct.product_category_name_english
ORDER BY  SUM(oi.price) DESC;


-- average rating by categories
SELECT p.product_category_name category_name, AVG(ore.review_score) AS AVG_score
FROM products p INNER JOIN order_items oi ON p.product_id=oi.product_id
	JOIN orders o ON oi.order_id=o.order_id
	JOIN order_reviews ore ON o.order_id=ore.order_id
GROUP BY p.product_category_name
ORDER BY p.product_category_name DESC;


-- top 5 sellers
SELECT TOP 5 s.seller_id, s.seller_zip_code_prefix, SUM(oi.price) AS total_revenue, COUNT(*) AS item_sold
FROM sellers s JOIN order_items oi ON s.seller_id=oi.seller_id
GROUP BY s.seller_id, s.seller_zip_code_prefix
ORDER BY SUM(oi.price) DESC;


-- revenue by month
SELECT 
    FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS order_month,
    SUM(oi.price) AS total_revenue
FROM order_items AS oi
JOIN orders AS o 
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY FORMAT(o.order_purchase_timestamp, 'yyyy-MM')
ORDER BY order_month ASC;