-- tests if there are any null values in the key columns in the table
SELECT *
FROM {{ source('fleetcomplete_5tran', 'idle_email') }}
WHERE ASSET IS NULL OR START_DATE IS NULL OR START_TIME IS NULL