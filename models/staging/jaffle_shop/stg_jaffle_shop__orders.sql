with 

source as (

    select * from {{ source('jaffle_shop', 'orders') }}

),

renamed as (

    select
        id AS order_id,
        user_id AS customer_id,
        order_date,
        status,
        _etl_loaded_at AS etl_loaded_at

    from source

)

select * from renamed
