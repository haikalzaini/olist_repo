{{ config(materialized='table') }}

SELECT DISTINCT
    DATE(order_date) AS date_key,
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    EXTRACT(DAY FROM order_date) AS day,
    EXTRACT(DAYOFWEEK FROM order_date) AS day_of_week
FROM {{ ref('stg_orders') }}
WHERE order_date IS NOT NULL