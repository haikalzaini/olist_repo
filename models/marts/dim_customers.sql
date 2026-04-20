{{ config(materialized='table') }}

WITH ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY customer_id
        ) AS rn
    FROM {{ ref('stg_customers') }}
)

SELECT
    customer_id,
    customer_city,
    customer_state
FROM ranked
WHERE rn = 1