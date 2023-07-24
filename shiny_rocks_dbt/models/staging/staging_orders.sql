

SELECT
    *
FROM {{ source('shiny_rocks', 'orders') }}