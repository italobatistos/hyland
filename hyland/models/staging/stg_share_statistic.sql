
with
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
    )
    
select *
from source_share_statistic