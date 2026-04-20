{{ config(materialized='table') }}

WITH ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY product_id
            ORDER BY product_id
        ) AS rn
    FROM {{ ref('stg_products') }}
)

SELECT
    product_id,
    product_category_name
FROM ranked
WHERE rn = 1