
SELECT
    month_year,
    platform,
    SUM(amount) AS sum_amount
FROM {{ ref("staging_marketing_investments") }}
GROUP BY month_year, platform