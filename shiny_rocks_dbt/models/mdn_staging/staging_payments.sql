

SELECT
    *,
    CONCAT(CAST(EXTRACT(YEAR FROM DATE (order_date)) AS STRING),'-',CAST(EXTRACT(MONTH FROM DATE (order_date)) AS STRING)) AS month_year
FROM {{ source('app_log', 'payments') }}