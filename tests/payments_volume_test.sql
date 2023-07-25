-- analyzes the average number of rows that a production table has per date for each office for the last 30 days and fail if the stage table has less than 20% of that average
WITH prod_data AS (
    SELECT DATE, officeid, COUNT(*) as row_count
    FROM {{ source('pestroutes', 'v_payments_indepth') }}
    WHERE DATE >= DATEADD(day, -30, CURRENT_DATE())
    GROUP BY DATE, officeid
),
stage_data AS (
    SELECT officeid, COUNT(*) as row_count
    FROM {{ source('pestroutes', 'v_payments_indepth') }}
    WHERE DATE = (current_date - interval '1 day')
    GROUP BY officeid
),
avg_prod_data AS (
    SELECT officeid, SUM(row_count) / COUNT(DISTINCT DATE) as avg_row_count
    FROM prod_data
    GROUP BY officeid
),

comparison AS (
    SELECT s.officeid, s.row_count < 0.2 * p.avg_row_count AS condition_met
    FROM stage_data s
    INNER JOIN avg_prod_data p ON s.officeid = p.officeid
)

SELECT officeid
FROM comparison
WHERE condition_met = TRUE