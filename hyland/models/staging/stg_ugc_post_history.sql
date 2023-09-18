
with
    ugc_post_history as (
        select
            cast(regexp_replace(id, '[^0-9]', '') as int) as post_id 
            , cast(regexp_replace(author, '[^0-9]', '') as int) as author_id     							
            , cast(created_time as date) as post_date	
            , cast(specific_content_share_commentary_text as string) as post_text 
            , cast(specific_content_share_media_category as string) as post_type
            , cast(commentary as string) as post_commentary
        from {{ source('linkedin','ugc_post_history') }}
    )
    
select *
from ugc_post_history