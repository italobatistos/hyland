WITH
    source_share_statistic AS (
        SELECT
            CAST(_fivetran_id AS STRING) AS _fivetran_id,
            CAST(REGEXP_REPLACE(_share_entity_urn, '[^0-9]', '') AS INT) AS share_entity_id,
            CAST(REGEXP_REPLACE(_organization_entity_urn, '[^0-9]', '') AS INT) AS organization_entity_id,
            CAST(engagement AS NUMERIC) AS engagement_rate,
            CAST(share_count AS INT) AS share,
            CAST(click_count AS INT) AS clicks,
            CAST(like_count AS INT) AS likes,
            CAST(impression_count AS INT) AS impressions,
            CAST(comment_count AS INT) AS comments
        FROM {{ source('linkedin','share_statistic') }}
        WHERE _organization_entity_urn NOT LIKE '%Brand%'
    )

/*with
    source_share_statistic as (
        select
            cast(_fivetran_id as string) as _fivetran_id
            , cast(regexp_replace(_share_entity_urn, '[^0-9]', '') as int) as share_entity_id 
            , cast(regexp_replace(_organization_entity_urn, '[^0-9]', '') as int) as organization_entity_id     							
            , cast(engagement as numeric) as engagement_rate	
            , cast(share_count as int) as share 
            , cast(click_count as int) as clicks
            , cast(like_count as int) as likes 
            , cast(impression_count as int) as impressions
            , cast(comment_count as int) as comments
        from {{ source('linkedin','share_statistic') }}
    )*/
    
select *
from source_share_statistic