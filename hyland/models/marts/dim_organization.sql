
with
    organization as (
        select *
        from{{ ref('stg_erp__organization')}}
    )

    , organization_entity_name as (
        select 
            organization.organization_id
            , organization.organization_name
        from organization
    )

    , transformations as (
        select
            row_number() over (order by organization_id) as sk_organization
            , *
        from organization_entity_name
    )

select *
from transformations