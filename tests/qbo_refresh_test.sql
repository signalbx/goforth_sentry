-- tests if all of the specified tables have been refreshed on today's date
WITH source_data AS (
    SELECT COUNT(*) AS row_count
    FROM {{ source('qbo_5tran', 'fivetran_audit') }}
    WHERE DATE(DONE) = CURRENT_DATE
)

SELECT row_count
FROM source_data
WHERE row_count = 0