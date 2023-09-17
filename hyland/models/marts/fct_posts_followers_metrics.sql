
with

    organization as (
        select *
        from{{ ref('dim_organization')}}
    )

    , followers as (
        select *
        from{{ ref('dim_followers')}}
    )

    , post_metrics as (
        select *
        from{{ ref('dim_post_metrics')}}
    )

    , join_posts_follwers_metric as (
        select 
            post_metrics.post_id
            , post_metrics.author_id
            , organization.organization_id
            , organization.organization_name
            , post_metrics.post_date
            , post_metrics.post_text
            , post_metrics.post_type
            , post_metrics.post_commentary
            , post_metrics.engagement
            , post_metrics.engagement_rate
            , post_metrics.share
            , post_metrics.clicks
            , post_metrics.likes
            , post_metrics.impressions
            , post_metrics.comments
            , followers.followers_organic
            , followers.followers_paid
        from post_metrics
        left join organization on
           post_metrics.author_id = organization.organization_id
        left join followers on
            post_metrics.author_id = followers.organization_entity_id
    )

    , transformations as (
        select
            {{ dbt_utils.generate_surrogate_key(['post_id', 'author_id']) }} as sk_post_metrics
            , *
        from join_posts_follwers_metric
    )

select *
from transformations