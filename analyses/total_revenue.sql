WITH payments AS (
    SELECT
    *
    FROM {{ ref("stg_stripe__payments") }} 
),

aggregated AS ( 
    SELECT
    SUM(amount) AS total_revenue 
    FROM payments 
    WHERE status = 'success' 
) 

SELECT
*
FROM aggregated 