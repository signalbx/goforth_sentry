-- tests if all of the specified tables have been refreshed on today's date
WITH source_data AS (
    SELECT COUNT(*) AS row_count
    FROM {{ source('google_sheets_internal', 'fivetran_audit') }}
    WHERE "TABLE" LIKE 'employees' AND DATE(DONE) = CURRENT_DATE
)

SELECT row_count
FROM source_data
WHERE row_count = 0