DROP DATABASE IF EXISTS assignment;
CREATE DATABASE IF NOT EXISTS assignment;
USE assignment;

/* Create the tables */
CREATE TABLE tbl_customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL UNIQUE,
    customer_city VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE tbl_salesReps (
    sales_rep_id VARCHAR(10) PRIMARY KEY,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100) NOT NULL UNIQUE,
    office_address VARCHAR(200) NOT NULL
);

CREATE TABLE tbl_orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    order_date DATE NOT NULL,
    sales_rep_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES tbl_customers(customer_id),
    FOREIGN KEY (sales_rep_id) REFERENCES tbl_salesReps(sales_rep_id)
);

CREATE TABLE tbl_orderItems (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES tbl_orders(order_id),
    FOREIGN KEY (product_id) REFERENCES tbl_products(product_id)
);

/* Insert customers */
INSERT INTO tbl_customers VALUES
('C001','Rohan Mehta','rohan@gmail.com','Mumbai'),
('C002','Priya Sharma','priya@gmail.com','Delhi'),
('C003','Amit Verma','amit@gmail.com','Bangalore'),
('C004','Sneha Iyer','sneha@gmail.com','Chennai'),
('C005','Vikram Singh','vikram@gmail.com','Mumbai'),
('C006','Neha Gupta','neha@gmail.com','Pune'),
('C007','Arjun Nair','arjun@gmail.com','Kochi');

/* Insert products */
INSERT INTO tbl_products VALUES
('P001','Laptop','Electronics',55000),
('P002','Mouse','Electronics',800),
('P003','Desk Chair','Furniture',8500),
('P004','Notebook','Stationery',120),
('P005','Headphones','Electronics',3200),
('P006','Standing Desk','Furniture',22000),
('P007','Pen Set','Stationery',500),
('P008','Webcam','Electronics',2100);

/* Insert sales reps */
INSERT INTO tbl_salesReps VALUES
('SR01','Deepak Joshi','deepak@corp.com','Mumbai HQ, Nariman Point, Mumbai - 400021'),
('SR02','Anita Desai','anita@corp.com','Delhi Office, Connaught Place, New Delhi - 110001'),
('SR03','Ravi Kumar','ravi@corp.com','South Zone, MG Road, Bangalore - 560001'),
('SR04','Meera Kapoor','meera@corp.com','Hyderabad Office, Banjara Hills, Hyderabad - 500034'),
('SR05','Arun Patel','arun@corp.com','Chennai Office, T Nagar, Chennai - 600017');

/* Insert orders (corrected) */
INSERT INTO tbl_orders VALUES
('ORD1114','C001','2023-08-06','SR01'),
('ORD1027','C002','2023-11-02','SR02'),
('ORD1153','C006','2023-02-14','SR01'),
('ORD1075','C005','2023-04-18','SR03'),
('ORD1132','C003','2023-03-07','SR02');

/* Insert order items (including missing products) */
INSERT INTO tbl_orderItems (order_id, product_id, quantity) VALUES
('ORD1114','P001',1),
('ORD1114','P002',2),
('ORD1027','P004',4),
('ORD1153','P005',3),
('ORD1075','P003',3),
('ORD1132','P002',5),
('ORD1153','P006',1),   
('ORD1075','P007',2),   
('ORD1132','P008',1);   
