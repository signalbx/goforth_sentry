-- analyzes the average number of rows that a production table has per date for the last 30 days and fail if the stage table has less than 20% of that average
WITH prod_data AS (
    SELECT DATE, COUNT(*) as row_count
    FROM {{ source('pestroutes_5tran', 'time_onsite_rpt') }}
    WHERE DATE >= DATEADD(day, -30, CURRENT_DATE())
    GROUP BY DATE
),
stage_data AS (
    SELECT COUNT(*) as row_count
    FROM {{ source('pestroutes_5tran', 'time_onsite_rpt') }}
    WHERE DATE = (current_date - interval '1 day')
),
avg_prod_data AS (
    SELECT SUM(row_count) / COUNT(DISTINCT DATE) as avg_row_count
    FROM prod_data
),

comparison AS (
    SELECT row_count < 0.2 * avg_row_count AS condition_met
    FROM stage_data, avg_prod_data
)

SELECT 1
FROM comparison
WHERE condition_met = TRUE