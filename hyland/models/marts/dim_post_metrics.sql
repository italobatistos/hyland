
with
    post_history as (
        select *
        from{{ ref('stg_erp__ugc_post_history')}}
    )

    , share_statistic as (
        select *
        from{{ ref('stg_erp__share_statistic')}}
    )

    , join_post_metrics as (
        select 
            post_history.author_id
            , post_history.post_id
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
        from share_statistic
        inner join post_history on
                  share_statistic.share_entity_id = post_history.post_id
    )

    , transformations as (
        select
            row_number() over (order by post_id) as sk_post
            , *
            , (clicks + likes + share + comments) as engagement
            , count(post_id) over (partition by author_id) as author_qty_post
        from join_post_metrics
    )

select *
from transformations