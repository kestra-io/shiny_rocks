

SELECT
    * EXCLUDE(order_date),
    TO_DATE(order_date, 'YYYY-MM-DD') AS order_date,
    CONCAT(CAST(EXTRACT(YEAR FROM DATE (TO_DATE(order_date, 'YYYY-MM-DD'))) AS STRING),'-',CAST(EXTRACT(MONTH FROM DATE (TO_DATE(order_date, 'YYYY-MM-DD'))) AS STRING)) AS month_year
FROM {{ source('app_log', 'orders') }}