SELECT
    date,
    CONCAT(CAST(EXTRACT(YEAR FROM DATE (date)) AS STRING),'-',CAST(EXTRACT(MONTH FROM DATE (date)) AS STRING)) AS month_year,
    CONCAT("_", platform) AS platform,
    amount
FROM {{ source('marketing', 'marketing_investments') }}