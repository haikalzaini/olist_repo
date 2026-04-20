CREATE OR REPLACE SCHEMA marts;

use schema marts;

CREATE OR REPLACE TABLE marts.fact_sales AS
SELECT
    oi.order_id,
    oi.order_item_id,
    o.customer_id,
    oi.product_id,
    oi.price,
    o.order_date
FROM staging.stg_order_items oi
JOIN staging.stg_orders o
    ON oi.order_id = o.order_id;
	
CREATE OR REPLACE TABLE marts.dim_customers AS
SELECT DISTINCT
    customer_id,
    customer_city,
    customer_state
FROM staging.stg_customers;

CREATE OR REPLACE TABLE marts.dim_products AS
SELECT DISTINCT
    product_id,
    product_category_name
FROM staging.stg_products;

CREATE OR REPLACE TABLE marts.dim_date AS
SELECT DISTINCT
    order_date AS date_key,
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    EXTRACT(DAY FROM order_date) AS day,
    EXTRACT(DAYOFWEEK FROM order_date) AS day_of_week
FROM staging.stg_orders
WHERE order_date IS NOT NULL;