-- Analysis by Product, Store, and Time of Day (with Month & Day Names)
SELECT 
    product_category,
    SUM(transaction_qty * unit_price) AS revenue,
    store_location,
    transaction_date,
    transaction_time,
    DAYNAME(transaction_date) AS month_name,
    MONTHNAME(transaction_date)   AS day_name,
    HOUR(transaction_time) AS Hours_of_the_day,
    -- Classify the transaction into time-of-day buckets for pattern analysis
    CASE
        WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning (06:00–11:59)'
        WHEN transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon (12:00–15:59)'
        WHEN transaction_time BETWEEN '16:00:00' AND '19:59:59' THEN 'Evening (16:00–19:59)'
        WHEN transaction_time >= '20:00:00' THEN 'Night (20:00–00:00)'
    END AS period_of_day
FROM PRACTICAL.MOHLALA.COFFEE
GROUP BY 
    product_category,
    store_location,
    transaction_date,
    transaction_time,
    month_name,
    day_name,
    period_of_day
ORDER BY revenue DESC;


