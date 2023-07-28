

SELECT
    month_year,
    payment_method,
    SUM(amount) AS sum_amount
FROM {{ ref("staging_payments") }}
GROUP BY month_year, payment_method