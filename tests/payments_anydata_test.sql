-- tests if there were any rows for yesterday in the nightly data load
WITH source_data AS (
    SELECT COUNT(*) AS row_count
    FROM {{ source('pestroutes', 'v_payments_indepth') }}
    WHERE DATE = (current_date - interval '1 day')
)

SELECT row_count
FROM source_data
WHERE row_count = 0