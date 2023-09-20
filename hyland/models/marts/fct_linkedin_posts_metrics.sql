
with

    int_post_metrics__organization as (
        select *
        from{{ ref('int_post_metrics__organization')}}
    )

    , post_metrics__organization as (
        select  *
        from int_post_metrics__organization
    )

    , transformations as (
        select
            {{ dbt_utils.generate_surrogate_key(['post_id', 'author_id']) }} as sk_post_metrics
            , *
        from post_metrics__organization
    )

    , latest_metric as (
        select        
            *
            , row_number() over (
                partition by post_id
                order by post_date desc
            ) as row_index
        from transformations
        qualify row_index <=1
        order by post_date asc
    )

select *
from latest_metric