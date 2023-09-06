

SELECT
    * EXCLUDE(run_date),
    TO_DATE(run_date, 'YYYY-MM-DD') AS run_date
FROM {{ source('app_log', 'services') }}