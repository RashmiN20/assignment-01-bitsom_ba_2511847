-- Q1: Total sales revenue by product category for each month
SELECT 
    d.year,
    d.month,
    p.category,
    SUM(f.total_sales) AS total_revenue
FROM fact_sales f
JOIN dim_date d ON f.date_id = d.date_id
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY d.year, d.month, p.category
ORDER BY d.year, d.month, total_revenue DESC;

-- Q2: Top 2 performing stores by total revenue
SELECT 
    s.store_name,
    s.store_city,
    SUM(f.total_sales) AS total_revenue
FROM fact_sales f
JOIN dim_store s ON f.store_id = s.store_id
GROUP BY s.store_name, s.store_city
ORDER BY total_revenue DESC
LIMIT 2;

-- Q3: Month-over-month sales trend across all stores
WITH monthly AS (
    SELECT
        d.year,
        d.month,
        SUM(f.total_sales) AS total_revenue
    FROM fact_sales f
    JOIN dim_date d ON f.date_id = d.date_id
    GROUP BY d.year, d.month
)
SELECT
    year,
    month,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY year, month) AS prev_month_revenue,
    ROUND(total_revenue - LAG(total_revenue) OVER (ORDER BY year, month), 2) AS mom_change
FROM monthly
ORDER BY year, month;

/*
The below query is a simplified version of Q3 without the month-over-month change calculation, 
just showing total revenue by month and year. 

You can uncomment it if you want to see the basic monthly revenue without the trend analysis.*/

/*
SELECT 
    d.year,
    d.month,
    DATE_FORMAT(d.full_date, '%M') AS month_name,
    SUM(f.total_sales) AS total_revenue
FROM fact_sales f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.year, d.month, month_name
ORDER BY d.year, d.month;*/
