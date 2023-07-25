-- tests if all of the specified tables have been refreshed on today's date
WITH source_data AS (
    SELECT COUNT(*) AS row_count
    FROM {{ source('google_ads_new', 'fivetran_audit') }}
    WHERE "TABLE" LIKE 'account_history' AND DATE(DONE) = CURRENT_DATE
    UNION ALL
    SELECT COUNT(*) AS row_count
    FROM {{ source('google_ads_new', 'fivetran_audit') }}
    WHERE "TABLE" LIKE 'ad_group_history' AND DATE(DONE) = CURRENT_DATE
    UNION ALL
    SELECT COUNT(*) AS row_count
    FROM {{ source('google_ads_new', 'fivetran_audit') }}
    WHERE "TABLE" LIKE 'ad_history' AND DATE(DONE) = CURRENT_DATE
    UNION ALL
    SELECT COUNT(*) AS row_count
    FROM {{ source('google_ads_new', 'fivetran_audit') }}
    WHERE "TABLE" LIKE 'campaign_history' AND DATE(DONE) = CURRENT_DATE
    UNION ALL
    SELECT COUNT(*) AS row_count
    FROM {{ source('google_ads_new', 'fivetran_audit') }}
    WHERE "TABLE" LIKE 'campaign_bidding_strategy_history' AND DATE(DONE) = CURRENT_DATE
    UNION ALL
    SELECT COUNT(*) AS row_count
    FROM {{ source('google_ads_new', 'fivetran_audit') }}
    WHERE "TABLE" LIKE 'ad_stats' AND DATE(DONE) = CURRENT_DATE
)

SELECT row_count
FROM source_data
WHERE row_count = 0
