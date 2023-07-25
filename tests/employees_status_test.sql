-- tests if any of the specified tables have a status other than 'Ok' for today's date
WITH source_data AS (
    SELECT COUNT(*) AS row_count
    FROM {{ source('google_sheets_internal', 'fivetran_audit') }}
    WHERE "TABLE" LIKE 'employees' AND DATE(DONE) = CURRENT_DATE AND STATUS != 'Ok'
)

SELECT row_count
FROM source_data
WHERE row_count > 0