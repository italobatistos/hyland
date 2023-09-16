
with
    ugc_post_share_statistic as (
        select  							
            cast(ugc_post_id as int) as post_id
        from {{ source('erp','ugc_post_share_statistic') }}
    )
    
select *
from ugc_post_share_statistic