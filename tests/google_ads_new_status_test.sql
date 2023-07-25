-- tests if any of the specified tables have a status other than 'Ok' for today's date
WITH source_data AS (
    SELECT COUNT(*) AS row_count
    FROM {{ source('google_ads_new', 'fivetran_audit') }}
    WHERE "TABLE" LIKE 'account_history' AND DATE(DONE) = CURRENT_DATE AND STATUS != 'Ok'
    UNION ALL
    SELECT COUNT(*) AS row_count
    FROM {{ source('google_ads_new', 'fivetran_audit') }}
    WHERE "TABLE" LIKE 'ad_group_history' AND DATE(DONE) = CURRENT_DATE AND STATUS != 'Ok'
    UNION ALL
    SELECT COUNT(*) AS row_count
    FROM {{ source('google_ads_new', 'fivetran_audit') }}
    WHERE "TABLE" LIKE 'ad_history' AND DATE(DONE) = CURRENT_DATE AND STATUS != 'Ok'
    UNION ALL
    SELECT COUNT(*) AS row_count
    FROM {{ source('google_ads_new', 'fivetran_audit') }}
    WHERE "TABLE" LIKE 'campaign_history' AND DATE(DONE) = CURRENT_DATE AND STATUS != 'Ok'
    UNION ALL
    SELECT COUNT(*) AS row_count
    FROM {{ source('google_ads_new', 'fivetran_audit') }}
    WHERE "TABLE" LIKE 'campaign_bidding_strategy_history' AND DATE(DONE) = CURRENT_DATE AND STATUS != 'Ok'
    UNION ALL
    SELECT COUNT(*) AS row_count
    FROM {{ source('google_ads_new', 'fivetran_audit') }}
    WHERE "TABLE" LIKE 'ad_stats' AND DATE(DONE) = CURRENT_DATE AND STATUS != 'Ok'
)

SELECT row_count
FROM source_data
WHERE row_count > 0