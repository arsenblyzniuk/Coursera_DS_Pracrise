USE OlistEcommerce;
GO

-- ============================================
-- DROP CLEAN TABLES IF EXISTS
-- ============================================

DROP TABLE IF EXISTS order_items;
GO

DROP TABLE IF EXISTS order_reviews;
GO

DROP TABLE IF EXISTS order_payments;
GO

DROP TABLE IF EXISTS orders;
GO

DROP TABLE IF EXISTS products;
GO

DROP TABLE IF EXISTS sellers;
GO

DROP TABLE IF EXISTS customers;
GO

DROP TABLE IF EXISTS geolocation;
GO

DROP TABLE IF EXISTS category_translation;
GO


-- ============================================
-- CLEAN TABLE: category_translation
-- ============================================

CREATE TABLE category_translation (
    product_category_name NVARCHAR(100) NOT NULL PRIMARY KEY,
    product_category_name_english NVARCHAR(100)
);
GO

INSERT INTO category_translation (
    product_category_name,
    product_category_name_english
)
SELECT
    TRIM(product_category_name),
    TRIM(product_category_name_english)
FROM stg_category_translation;
GO


-- ============================================
-- CLEAN TABLE: geolocation
-- ============================================

CREATE TABLE geolocation (
    geolocation_zip_code_prefix VARCHAR(10) NOT NULL PRIMARY KEY,
    geolocation_lat DECIMAL(9,6),
    geolocation_lng DECIMAL(9,6),
    geolocation_city VARCHAR(100),
    geolocation_state CHAR(2)
);
GO

INSERT INTO geolocation (
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
)
SELECT
    TRIM(geolocation_zip_code_prefix),
    AVG(TRY_CONVERT(DECIMAL(9,6), geolocation_lat)),
    AVG(TRY_CONVERT(DECIMAL(9,6), geolocation_lng)),
    MIN(TRIM(geolocation_city)),
    MIN(TRIM(geolocation_state))
FROM stg_geolocation
WHERE geolocation_zip_code_prefix IS NOT NULL
GROUP BY TRIM(geolocation_zip_code_prefix);
GO


-- ============================================
-- CLEAN TABLE: customers
-- ============================================

CREATE TABLE customers (
    customer_id VARCHAR(50) NOT NULL PRIMARY KEY,
    customer_unique_id VARCHAR(50) NOT NULL,
    customer_zip_code_prefix VARCHAR(10),
    customer_city VARCHAR(100),
    customer_state CHAR(2)
);
GO

INSERT INTO customers (
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
)
SELECT
    TRIM(customer_id),
    TRIM(customer_unique_id),
    TRIM(customer_zip_code_prefix),
    TRIM(customer_city),
    TRIM(customer_state)
FROM stg_customers;
GO


-- ============================================
-- CLEAN TABLE: sellers
-- ============================================

CREATE TABLE sellers (
    seller_id VARCHAR(50) NOT NULL PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(10),
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);
GO

INSERT INTO sellers (
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
)
SELECT
    TRIM(seller_id),
    TRIM(seller_zip_code_prefix),
    TRIM(seller_city),
    TRIM(seller_state)
FROM stg_sellers;
GO


-- ============================================
-- CLEAN TABLE: products
-- ============================================

CREATE TABLE products (
    product_id VARCHAR(50) NOT NULL PRIMARY KEY,
    product_category_name NVARCHAR(100),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);
GO

INSERT INTO products (
    product_id,
    product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
)
SELECT
    TRIM(product_id),
    NULLIF(TRIM(product_category_name), ''),
    TRY_CONVERT(INT, product_name_lenght),
    TRY_CONVERT(INT, product_description_lenght),
    TRY_CONVERT(INT, product_photos_qty),
    TRY_CONVERT(INT, product_weight_g),
    TRY_CONVERT(INT, product_length_cm),
    TRY_CONVERT(INT, product_height_cm),
    TRY_CONVERT(INT, product_width_cm)
FROM stg_products;
GO


-- ============================================
-- CLEAN TABLE: orders
-- ============================================

CREATE TABLE orders (
    order_id VARCHAR(50) NOT NULL PRIMARY KEY,
    customer_id VARCHAR(50) NOT NULL,
    order_status VARCHAR(30),
    order_purchase_timestamp DATETIME2,
    order_approved_at DATETIME2,
    order_delivered_carrier_date DATETIME2,
    order_delivered_customer_date DATETIME2,
    order_estimated_delivery_date DATETIME2
);
GO

INSERT INTO orders (
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
)
SELECT
    TRIM(order_id),
    TRIM(customer_id),
    TRIM(order_status),
    TRY_CONVERT(DATETIME2, order_purchase_timestamp),
    TRY_CONVERT(DATETIME2, order_approved_at),
    TRY_CONVERT(DATETIME2, order_delivered_carrier_date),
    TRY_CONVERT(DATETIME2, order_delivered_customer_date),
    TRY_CONVERT(DATETIME2, order_estimated_delivery_date)
FROM stg_orders;
GO


-- ============================================
-- CLEAN TABLE: order_payments
-- ============================================

CREATE TABLE order_payments (
    order_id VARCHAR(50) NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value DECIMAL(10,2),

    CONSTRAINT PK_order_payments 
        PRIMARY KEY (order_id, payment_sequential)
);
GO

INSERT INTO order_payments (
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
)
SELECT
    TRIM(order_id),
    TRY_CONVERT(INT, payment_sequential),
    TRIM(payment_type),
    TRY_CONVERT(INT, payment_installments),
    TRY_CONVERT(DECIMAL(10,2), payment_value)
FROM stg_order_payments;
GO


-- ============================================
-- CLEAN TABLE: order_reviews
-- ============================================

CREATE TABLE order_reviews (
    review_row_id INT IDENTITY(1,1) PRIMARY KEY,
    review_id VARCHAR(50),
    order_id VARCHAR(50) NOT NULL,
    review_score INT,
    review_comment_title VARCHAR(500),
    review_comment_message VARCHAR(500),
    review_creation_date DATETIME2,
    review_answer_timestamp DATETIME2
);
GO

INSERT INTO order_reviews (
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
)
SELECT
    TRIM(review_id),
    TRIM(order_id),
    TRY_CONVERT(INT, review_score),
    NULLIF(TRIM(review_comment_title), ''),
    NULLIF(TRIM(review_comment_message), ''),
    TRY_CONVERT(DATETIME2, review_creation_date),
    TRY_CONVERT(DATETIME2, review_answer_timestamp)
FROM stg_order_reviews;
GO


-- ============================================
-- CLEAN TABLE: order_items
-- ============================================

CREATE TABLE order_items (
    order_id VARCHAR(50) NOT NULL,
    order_item_id INT NOT NULL,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME2,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),

    CONSTRAINT PK_order_items
        PRIMARY KEY (order_id, order_item_id)
);
GO

INSERT INTO order_items (
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
)
SELECT
    TRIM(order_id),
    TRY_CONVERT(INT, order_item_id),
    TRIM(product_id),
    TRIM(seller_id),
    TRY_CONVERT(DATETIME2, shipping_limit_date),
    TRY_CONVERT(DECIMAL(10,2), price),
    TRY_CONVERT(DECIMAL(10,2), freight_value)
FROM stg_order_items;
GO