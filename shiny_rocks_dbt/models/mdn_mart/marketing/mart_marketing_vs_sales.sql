
WITH orders_utm_values AS (
    SELECT
        orders.order_date,
        orders.utm_source,
        SUM(payments.amount) AS sum_payments_amount
    FROM {{ ref("staging_orders")}} AS orders
    INNER JOIN {{ ref("staging_payments") }} AS payments
    ON orders.order_id = payments.order_id
    GROUP BY orders.order_date, orders.utm_source
)

, marketing_sales_agg AS (
    SELECT
        date,
        platform,
        amount AS marketing_cost,
        sum_payments_amount AS sales_amount
    FROM {{ ref("staging_marketing_investments") }} AS marketing_month_agg
    INNER JOIN orders_utm_values
    ON marketing_month_agg.date = orders_utm_values.order_date AND marketing_month_agg.platform = orders_utm_values.utm_source
)

SELECT
    date,
    platform,
    marketing_cost,
    sales_amount,
    (sales_amount - marketing_cost) / marketing_cost AS marketing_roi
FROM marketing_sales_agg