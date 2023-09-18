
with

    organization as (
        select *
        from{{ ref('stg_organization')}}
    )

    , post_history as (
        select *
        from{{ ref('stg_ugc_post_history')}}
    )

    , share_statistic as (
        select *
        from{{ ref('stg_share_statistic')}}
    )

    , join_posts_metric as (
        select 
            post_history.post_id
            , post_history.author_id
            , organization.organization_id
            , organization.organization_name
            , post_history.post_date
            , post_history.post_text
            , post_history.post_type
            , post_history.post_commentary
            , share_statistic.share
            , share_statistic.clicks
            , share_statistic.likes
            , share_statistic.impressions
            , share_statistic.comments
            , share_statistic.engagement_rate
        from post_history
        inner join share_statistic on
                   post_history.post_id = share_statistic.share_entity_id
        left join organization on
           post_history.author_id = organization.organization_id
    )

    , transformations as (
        select
            row_number() over (order by post_id) as sk_post
            , *
            , (clicks + likes + share + comments) as engagement
        from join_posts_metric
    )

select *
from transformations