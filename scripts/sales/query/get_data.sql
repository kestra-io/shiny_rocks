SELECT
    orders.order_date,
    product_id,
    COUNT(orders.order_id) AS nb_order
FROM shiny_rocks.orders AS orders
LEFT JOIN shiny_rocks.payments AS payments
ON orders.order_id = payments.order_id
GROUP BY order_date, product_id