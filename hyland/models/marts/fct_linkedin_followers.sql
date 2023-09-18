
with
    followers as (
        select *
        from{{ ref('stg_followers_by_country')}}
    )

    , followers_metric as (
        select 
            followers.organization_entity_id
            , followers.followers_organic
            , followers.followers_paid
        from followers
    )

    , transformations as (
        select
            row_number() over (order by organization_entity_id) as sk_organization_entity
            , organization_entity_id
            , sum(followers_organic) as followers_organic
            , sum(followers_paid) as followers_paid
        from followers_metric
        group by organization_entity_id
        
    )

select *
from transformations