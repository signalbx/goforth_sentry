-- tests if all of the specified tables have been refreshed on today's date
WITH source_data AS (
    SELECT COUNT(*) AS row_count
    FROM {{ source('google_sheets', 'fivetran_audit') }}
    WHERE "TABLE" LIKE 'agent_goals' AND DATE(DONE) = CURRENT_DATE
)

SELECT row_count
FROM source_data
WHERE row_count = 0