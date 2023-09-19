
with
    followers as (
        select *
        from{{ ref('stg_followers_by_country')}}
    )

    , organization as (
        select *
        from{{ref('stg_organization')}}
    )

    , followers_metric as (
        select 
            followers.organization_entity_id
            , organization.organization_name
            , followers.fivetran_synced
            , followers.followers_organic
            , followers.followers_paid
        from followers
        left join organization on
            followers.organization_entity_id = organization.organization_id
    )

    , transformations as (
        select
            row_number() over (order by organization_entity_id) as  sk_organization_entity
            , *
        from followers_metric

        
    )

select *
from transformations