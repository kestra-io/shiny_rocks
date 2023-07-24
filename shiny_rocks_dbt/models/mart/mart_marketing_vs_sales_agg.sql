
WITH orders_utm_values AS (
    SELECT
        orders.month_year,
        orders.utm_source,
        SUM(payments.amount) AS sum_payments_amount
    FROM {{ ref("staging_orders")}} AS orders
    INNER JOIN {{ ref("staging_payments") }} AS payments
    ON orders.order_id = payments.order_id
    GROUP BY orders.month_year, orders.utm_source
)

, marketing_sales_agg AS (
    SELECT
        marketing_month_agg.month_year,
        platform,
        sum_amount AS marketing_cost,
        sum_payments_amount AS sales_amount
    FROM {{ ref("mart_marketing_month_agg")}} AS marketing_month_agg
    LEFT JOIN orders_utm_values
    ON marketing_month_agg.month_year = orders_utm_values.month_year AND marketing_month_agg.platform = orders_utm_values.utm_source
)

SELECT
    month_year,
    platform,
    marketing_cost,
    sales_amount,
    (sales_amount - marketing_cost) / marketing_cost AS marketing_roi
FROM marketing_sales_agg
