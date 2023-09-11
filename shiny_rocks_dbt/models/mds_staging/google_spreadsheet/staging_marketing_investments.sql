SELECT
    TO_DATE(date, 'YYYY/MM/DD') AS date,
    CONCAT(CAST(EXTRACT(YEAR FROM DATE (TO_DATE(date, 'YYYY/MM/DD'))) AS STRING),'-',CAST(EXTRACT(MONTH FROM DATE (TO_DATE(date, 'YYYY/MM/DD'))) AS STRING)) AS month_year,
    CONCAT('_', platform) AS platform,
    amount
FROM {{ source('marketing', 'marketing_investments') }}