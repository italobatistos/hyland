
with
    followers_organization as (
        select *
        from{{ ref('int_followers__organization')}}
    )

    , followers_metric as (
        select *
        from followers_organization

    )

    , transformations as (
        select
            {{ dbt_utils.generate_surrogate_key(['organization_entity_id', 'fivetran_synced']) }} as sk_organization_followers
            , *
        from followers_metric

        
    )

select *
from transformations