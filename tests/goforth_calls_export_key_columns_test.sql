-- tests if there are any null values in the key columns in the table
SELECT *
FROM {{ source('calltrackingmetrics', 'goforth_calls_export') }}
WHERE DATE IS NULL OR TIME IS NULL OR TRACKING_ IS NULL OR CUSTOMER_ IS NULL