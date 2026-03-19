-- Q1: List all customers from Mumbai along with their total order value
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(p.unit_price * oi.quantity) AS total_order_value
FROM 
    tbl_customers c
JOIN 
    tbl_orders o ON c.customer_id = o.customer_id
JOIN 
    tbl_orderItems oi ON o.order_id = oi.order_id
JOIN 
    tbl_products p ON oi.product_id = p.product_id
WHERE 
    c.customer_city = 'Mumbai'
GROUP BY 
    c.customer_id, c.customer_name;

-- Q2: Find the top 3 products by total quantity sold
SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM 
    tbl_products p
JOIN 
    tbl_orderItems oi ON p.product_id = oi.product_id
GROUP BY 
    p.product_id, p.product_name
ORDER BY 
    total_quantity_sold DESC
LIMIT 3;

-- Q3: List all sales representatives and the number of unique customers they have handled
SELECT 
    s.sales_rep_id,
    s.sales_rep_name,
    COUNT(DISTINCT o.customer_id) AS unique_customers_handled
FROM 
    tbl_salesReps s
LEFT JOIN 
    tbl_orders o ON s.sales_rep_id = o.sales_rep_id
GROUP BY 
    s.sales_rep_id, s.sales_rep_name;

-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
SELECT 
    o.order_id,
    c.customer_name,
    SUM(p.unit_price * oi.quantity) AS total_value
FROM 
    tbl_orders o
JOIN 
    tbl_customers c ON o.customer_id = c.customer_id
JOIN 
    tbl_orderItems oi ON o.order_id = oi.order_id
JOIN 
    tbl_products p ON oi.product_id = p.product_id
GROUP BY 
    o.order_id, c.customer_name
HAVING 
    total_value > 10000
ORDER BY 
    total_value DESC;

-- Q5: Identify any products that have never been ordered
SELECT 
    p.product_id,
    p.product_name
FROM 
    tbl_products p
LEFT JOIN 
    tbl_orderItems oi ON p.product_id = oi.product_id
WHERE 
    oi.product_id IS NULL;

-- Note: Every product in the dataset has been ordered at least once.
-- This query is correct but returns no results here.
