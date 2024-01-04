SELECT
    platform,
    marketing_cost,
    sales_amount,
    marketing_roi
FROM shiny_rocks.mart_marketing_vs_sales
WHERE date = DATE_ADD("{{ trigger.date ?? now() | date(format='YYYY-MM-dd') }}", INTERVAL -3 DAY)