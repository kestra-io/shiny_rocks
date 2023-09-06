

SELECT
    *
FROM {{ source('app_log', 'services') }}