
with
    followers_by_country as (
        select  							
            cast(regexp_replace(_organization_entity_urn, '[^0-9]', '') as int) as organization_entity_id 
            , cast(_fivetran_synced as date) as fivetran_synced
            , cast(follower_counts_organic_follower_count as int) as followers_organic
            , cast(follower_counts_paid_follower_count as int) as followers_paid
        from {{ source('erp','follower_by_country') }}
        where _organization_entity_urn not like '%Brand%'
    )
    
select *
from followers_by_country