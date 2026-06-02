USE OlistEcommerce;
GO

-- ============================================
-- DROP STAGING TABLES IF EXISTS
-- ============================================

DROP TABLE IF EXISTS stg_order_reviews;
DROP TABLE IF EXISTS stg_order_payments;
DROP TABLE IF EXISTS stg_order_items;
DROP TABLE IF EXISTS stg_orders;
DROP TABLE IF EXISTS stg_products;
DROP TABLE IF EXISTS stg_sellers;
DROP TABLE IF EXISTS stg_customers;
DROP TABLE IF EXISTS stg_geolocation;
DROP TABLE IF EXISTS stg_category_translation;
GO


-- ============================================
-- CREATE STAGING TABLES
-- ============================================

CREATE TABLE stg_category_translation (
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100)
);
GO

CREATE TABLE stg_geolocation (
    geolocation_zip_code_prefix VARCHAR(10),
    geolocation_lat VARCHAR(50),
    geolocation_lng VARCHAR(50),
    geolocation_city VARCHAR(100),
    geolocation_state CHAR(2)
);
GO

CREATE TABLE stg_customers (
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix VARCHAR(10),
    customer_city VARCHAR(100),
    customer_state CHAR(2)
);
GO

CREATE TABLE stg_sellers (
    seller_id VARCHAR(50),
    seller_zip_code_prefix VARCHAR(10),
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);
GO

CREATE TABLE stg_products (
    product_id VARCHAR(50),
    product_category_name VARCHAR(100),
    product_name_lenght VARCHAR(50),
    product_description_lenght VARCHAR(50),
    product_photos_qty VARCHAR(50),
    product_weight_g VARCHAR(50),
    product_length_cm VARCHAR(50),
    product_height_cm VARCHAR(50),
    product_width_cm VARCHAR(50)
);
GO

CREATE TABLE stg_orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(30),
    order_purchase_timestamp VARCHAR(50),
    order_approved_at VARCHAR(50),
    order_delivered_carrier_date VARCHAR(50),
    order_delivered_customer_date VARCHAR(50),
    order_estimated_delivery_date VARCHAR(50)
);
GO

CREATE TABLE stg_order_items (
    order_id VARCHAR(50),
    order_item_id VARCHAR(50),
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date VARCHAR(50),
    price VARCHAR(50),
    freight_value VARCHAR(50)
);
GO

CREATE TABLE stg_order_payments (
    order_id VARCHAR(50),
    payment_sequential VARCHAR(50),
    payment_type VARCHAR(50),
    payment_installments VARCHAR(50),
    payment_value VARCHAR(50)
);
GO

CREATE TABLE stg_order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score VARCHAR(50),
    review_comment_title NVARCHAR(255),
    review_comment_message NVARCHAR(MAX),
    review_creation_date VARCHAR(50),
    review_answer_timestamp VARCHAR(50)
);
GO


-- ============================================
-- BULK INSERT DATA INTO STAGING TABLES
-- ============================================

BULK INSERT stg_category_translation
FROM 'C:\Users\arsen\OneDrive\!MyFiles\PetProjects\SQL\P1\data\product_category_name_translation.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);
GO

BULK INSERT stg_geolocation
FROM 'C:\Users\arsen\OneDrive\!MyFiles\PetProjects\SQL\P1\data\olist_geolocation_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);
GO

BULK INSERT stg_customers
FROM 'C:\Users\arsen\OneDrive\!MyFiles\PetProjects\SQL\P1\data\olist_customers_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);
GO

BULK INSERT stg_sellers
FROM 'C:\Users\arsen\OneDrive\!MyFiles\PetProjects\SQL\P1\data\olist_sellers_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);
GO

BULK INSERT stg_products
FROM 'C:\Users\arsen\OneDrive\!MyFiles\PetProjects\SQL\P1\data\olist_products_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);
GO

BULK INSERT stg_orders
FROM 'C:\Users\arsen\OneDrive\!MyFiles\PetProjects\SQL\P1\data\olist_orders_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);
GO

BULK INSERT stg_order_items
FROM 'C:\Users\arsen\OneDrive\!MyFiles\PetProjects\SQL\P1\data\olist_order_items_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);
GO

BULK INSERT stg_order_payments
FROM 'C:\Users\arsen\OneDrive\!MyFiles\PetProjects\SQL\P1\data\olist_order_payments_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);
GO

BULK INSERT stg_order_reviews
FROM 'C:\Users\arsen\OneDrive\!MyFiles\PetProjects\SQL\P1\data\olist_order_reviews_dataset_clean.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);
GO