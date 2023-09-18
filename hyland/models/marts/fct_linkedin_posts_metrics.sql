
with

    int_post_metrics__organization as (
        select *
        from{{ ref('int_post_metrics__organization')}}
    )

    , post_metrics__organization as (
        select 
           *
        from int_post_metrics__organization
    )

    , transformations as (
        select
            {{ dbt_utils.generate_surrogate_key(['post_id', 'author_id']) }} as sk_post_metrics
            , *
        from post_metrics__organization
    )

select *
from transformations