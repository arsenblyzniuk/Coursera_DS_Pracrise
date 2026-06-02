-- customers -> geolocation ||| customers.customer_zip_code_prefix -- geolocation.geolocation_zip_code_prefix
-- sellers -> geolocation ||| sellers.seller_zip_code_prefix -- geolocation.geolocation_zip_code_prefix
-- products -> category_translation ||| products.product_category_name -- category_translation.product_category_name

-- orders -> customers
ALTER TABLE orders
ADD CONSTRAINT FK_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);
GO

-- order_payments -> orders
ALTER TABLE order_payments
ADD CONSTRAINT FK_order_payments_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);
GO

-- order_reviews -> orders
ALTER TABLE order_reviews
ADD CONSTRAINT FK_order_reviews_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);
GO

-- order_items -> orders
ALTER TABLE order_items
ADD CONSTRAINT FK_order_items_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);
GO

-- order_items -> products
ALTER TABLE order_items
ADD CONSTRAINT FK_order_items_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);
GO

-- order_items -> sellers
ALTER TABLE order_items
ADD CONSTRAINT FK_order_items_sellers
FOREIGN KEY (seller_id)
REFERENCES sellers(seller_id);
GO