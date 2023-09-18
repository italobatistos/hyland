
with
    organization as (
        select  							
            cast(id as int) as organization_id
            , cast(localized_name as string) as organization_name
        from {{ source('linkedin','organization') }}
    )
    
select *
from organization