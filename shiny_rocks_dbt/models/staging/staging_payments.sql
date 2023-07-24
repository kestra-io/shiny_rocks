

SELECT
    *
FROM {{ source('app_log', 'payments') }}