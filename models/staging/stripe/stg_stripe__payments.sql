with 

source as (

    select * from {{ source('stripe', 'payments') }}

),

renamed as (

    select
        id AS payment_id,
        orderid AS order_id,
        paymentmethod AS payment_method,
        status,
        amount,
        created,
        _batched_at AS batched_at

    from source

)

select * from renamed
