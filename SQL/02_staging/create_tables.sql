CREATE OR REPLACE SCHEMA staging;

use schema staging;

CREATE OR REPLACE TABLE staging.stg_orders AS
SELECT
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp AS order_date,
    order_delivered_customer_date
FROM raw.orders;

CREATE OR REPLACE TABLE staging.stg_customers AS
SELECT
    customer_id,
    customer_city,
    customer_state
FROM raw.customers;

CREATE OR REPLACE TABLE staging.stg_order_items AS
SELECT
    order_id,
    order_item_id,
    product_id,
    price,
    freight_value
FROM raw.order_items;

CREATE OR REPLACE TABLE staging.stg_products AS
SELECT
    product_id,
    product_category_name
FROM raw.products;