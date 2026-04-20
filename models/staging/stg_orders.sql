SELECT
    order_id,
    customer_id,
    order_purchase_timestamp AS order_date,
    order_status,
    order_delivered_customer_date
FROM raw.orders