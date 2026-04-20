{{ config(materialized='table') }}

SELECT
    oi.order_id,
    oi.order_item_id,
    o.customer_id,
    oi.product_id,
    oi.price,
    o.order_date
FROM {{ ref('stg_order_items') }} oi
JOIN {{ ref('stg_orders') }} o
    ON oi.order_id = o.order_id
WHERE oi.price > 0
  AND o.customer_id IS NOT NULL