with 

source as (

    select * from {{ source('jaffle_shop', 'orders') }}

),

renamed as (

    select
        id AS order_id,
        user_id AS customer_id,
        order_date,
        DATE_DIFF({{ dbt.current_timestamp() }}, CAST(order_date AS TIMESTAMP), DAY) AS days_since_ordered,
        status LIKE '%pending%' AS is_status_pending,
        CASE
            WHEN status LIKE '%shipped%' THEN 'shipped'
            WHEN status LIKE '%return%' THEN 'returned'
            WHEN status LIKE '%pending%' THEN 'placed'
            ELSE status
        END AS status,
        _etl_loaded_at AS etl_loaded_at

    from source

)

select * from renamed
