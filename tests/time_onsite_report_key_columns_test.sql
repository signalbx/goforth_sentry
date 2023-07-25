-- tests if there are any null values in the key columns in the table
SELECT *
FROM {{ source('pestroutes_5tran', 'time_onsite_report') }}
WHERE TECH_ID IS NULL OR OFFICE_NAME IS NULL