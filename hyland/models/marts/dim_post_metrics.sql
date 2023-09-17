
with
    post_statistic as (
        select *
        from{{ ref('stg_erp__ugc_post_share_statistic')}}
    )

    , post_history as (
        select *
        from{{ ref('stg_erp__ugc_post_history')}}
    )

    , share_statistic as (
        select *
        from{{ ref('stg_erp__share_statistic')}}
    )

    , join_post_metrics as (
        select 
            post_statistic.post_id
            , post_history.author_id
            , post_history.post_date
            , post_history.post_text
            , post_history.post_type
            , post_history.post_commentary
            , share_statistic.engagement_rate
            , share_statistic.share
            , share_statistic.clicks
            , share_statistic.likes
            , share_statistic.impressions
            , share_statistic.comments
        from post_statistic
        left join post_history on
                  post_statistic.post_id = post_history.post_id
        left join share_statistic on
                  post_statistic.post_id = share_statistic.share_entity_id
    )

    , transformations as (
        select
            row_number() over (order by post_id) as sk_post
            , *
            , count(post_id) over (partition by author_id) as author_qty_post
        from join_post_metrics
    )

select *
from transformations