DROP DATABASE IF EXISTS dw_assignment;

CREATE DATABASE  IF NOT EXISTS dw_assignment;

USE dw_assignment;

-- Date Dimension
CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE NOT NULL,
    day INT,
    month INT,
    year INT
);

-- Store Dimension
CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    store_city VARCHAR(100) NOT NULL
);

-- Product Dimension
CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL
);

-- Customer Dimension
CREATE TABLE dim_customer (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_city VARCHAR(100),
    customer_segment VARCHAR(50)
);

-- Sales Fact Table
CREATE TABLE fact_sales (
    sales_id INT PRIMARY KEY,
    transaction_id VARCHAR(20) NOT NULL,
    date_id INT NOT NULL,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    customer_id VARCHAR(20) NOT NULL,
    units_sold INT NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,
    total_sales DECIMAL(15,2) GENERATED ALWAYS AS (units_sold * unit_price) STORED,
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id)
);

-- Date Dimension
INSERT INTO dim_date VALUES
(1, '2023-08-29', 29, 8, 2023),
(2, '2023-12-12', 12, 12, 2023),
(3, '2023-02-05', 5, 2, 2023),
(4, '2023-01-15', 15, 1, 2023),
(5, '2023-08-09', 9, 8, 2023),
(6, '2023-10-26', 26, 10, 2023),
(7, '2023-06-04', 4, 6, 2023),
(8, '2023-11-18', 18, 11, 2023),
(9, '2023-07-22', 22, 7, 2023),
(10, '2023-09-27', 27, 9, 2023);

-- Store Dimension
INSERT INTO dim_store VALUES
(1, 'Chennai Anna', 'Chennai'),
(2, 'Delhi South', 'Delhi'),
(3, 'Bangalore MG', 'Bangalore'),
(4, 'Pune FC Road', 'Pune'),
(5, 'Mumbai Central', 'Mumbai');

-- Product Dimension
INSERT INTO dim_product VALUES
(1, 'Speaker', 'Electronics'),
(2, 'Tablet', 'Electronics'),
(3, 'Phone', 'Electronics'),
(4, 'Smartwatch', 'Electronics'),
(5, 'Atta 10kg', 'Grocery'),
(6, 'Jeans', 'Clothing'),
(7, 'Jacket', 'Clothing'),
(8, 'Laptop', 'Electronics'),
(9, 'Milk 1L', 'Grocery'),
(10, 'Saree', 'Clothing');

INSERT INTO dim_customer VALUES
('CUST045', 'Arun Kumar', 'Chennai', 'Retail'),
('CUST021', 'Priya Sharma', 'Chennai', 'Retail'),
('CUST019', 'Ravi Iyer', 'Chennai', 'Retail'),
('CUST004', 'Meena Raghavan', 'Chennai', 'Retail'),
('CUST027', 'Suresh Menon', 'Bangalore', 'Retail'),
('CUST041', 'Anita Desai', 'Pune', 'Retail'),
('CUST031', 'Vikram Rao', 'Chennai', 'Retail'),
('CUST042', 'Neha Kapoor', 'Delhi', 'Retail'),
('CUST008', 'Karthik Nair', 'Chennai', 'Retail'),
('CUST015', 'Rajesh Patel', 'Mumbai', 'Retail');


INSERT INTO fact_sales (sales_id, transaction_id, date_id, store_id, product_id, customer_id, units_sold, unit_price)
VALUES
(1, 'TXN5000', 1, 1, 1, 'CUST045', 3, 49262.78),
(2, 'TXN5001', 2, 1, 2, 'CUST021', 11, 23226.12),
(3, 'TXN5002', 3, 1, 3, 'CUST019', 20, 48703.39),
(4, 'TXN5004', 4, 1, 4, 'CUST004', 10, 58851.01),
(5, 'TXN5005', 5, 3, 5, 'CUST027', 12, 52464.00),
(6, 'TXN5007', 6, 4, 6, 'CUST041', 16, 2317.47),
(7, 'TXN5010', 7, 1, 7, 'CUST031', 15, 30187.24),
(8, 'TXN5014', 8, 2, 7, 'CUST042', 5, 30187.24),
(9, 'TXN5019', 9, 1, 5, 'CUST008', 3, 52464.00),
(10, 'TXN5034', 10, 5, 1, 'CUST031', 14, 49262.78);