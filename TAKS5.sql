CREATE DATABASE FashionShopDB;
USE FashionShopDB;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15)
);

INSERT INTO Customer VALUES
(1, 'Arun Kumar', 'arun@gmail.com', '9876543210'),
(2, 'Priya S', 'priya@gmail.com', '9876543211'),
(3, 'Rahul M', 'rahul@gmail.com', '9876543212'),
(4, 'Divya R', 'divya@gmail.com', '9876543213'),
(5, 'Karthik V', 'karthik@gmail.com', '9876543214');

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO Product VALUES
(101, 'Cotton T-Shirt', 'Men', 599.00),
(102, 'Denim Jeans', 'Men', 1299.00),
(103, 'Women Kurti', 'Women', 899.00),
(104, 'Casual Shirt', 'Men', 799.00),
(105, 'Women Handbag', 'Accessories', 999.00),
(106, 'Sports Shoes', 'Footwear', 1599.00);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

INSERT INTO Orders VALUES
(1001, 1, '2026-08-20', 599.00),
(1002, 2, '2026-08-21', 1299.00),
(1003, 3, '2026-08-21', 899.00),
(1004, 1, '2026-08-22', 1599.00),
(1005, 4, '2026-08-23', 999.00),
(1006, 5, '2026-08-24', 799.00);

CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    payment_mode VARCHAR(30) NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

INSERT INTO Payment VALUES
(501, 1001, 1, 'UPI', '2026-08-20', 599.00, 'SUCCESS'),
(502, 1002, 2, 'Credit Card', '2026-08-21', 1299.00, 'SUCCESS'),
(503, 1003, 3, 'Net Banking', '2026-08-21', 899.00, 'FAILED'),
(504, 1004, 1, 'Debit Card', '2026-08-22', 1599.00, 'SUCCESS'),
(505, 1005, 4, 'UPI', '2026-08-23', 999.00, 'PENDING'),
(506, 1006, 5, 'UPI', '2026-08-24', 799.00, 'SUCCESS');

SELECT * FROM Payment;

SELECT *
FROM Payment
WHERE status = 'SUCCESS';

SELECT *
FROM Payment
WHERE status = 'FAILED';

SELECT *
FROM Payment
WHERE status = 'PENDING';

SELECT payment_mode,
       COUNT(*) AS transaction_count,
       SUM(amount) AS total_amount
FROM Payment
GROUP BY payment_mode
ORDER BY transaction_count DESC;

    SELECT 
    c.customer_id,
    c.customer_name,
    p.payment_id,
    p.payment_mode,
    p.payment_date,
    p.amount,
    p.status
FROM Customer c
JOIN Payment p
ON c.customer_id = p.customer_id
ORDER BY c.customer_id;

SELECT SUM(amount) AS total_successful_payment
FROM Payment
WHERE status = 'SUCCESS';

SELECT status,
       COUNT(*) AS transaction_count
FROM Payment
GROUP BY status;

SELECT payment_date,
       COUNT(*) AS transaction_count,
       SUM(amount) AS total_amount
FROM Payment
GROUP BY payment_date
ORDER BY payment_date;

SELECT *
FROM Payment
WHERE amount = (SELECT MAX(amount) FROM Payment);

SELECT 
    c.customer_name,
    SUM(p.amount) AS total_paid
FROM Customer c
JOIN Payment p
ON c.customer_id = p.customer_id
WHERE p.status = 'SUCCESS'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_paid DESC;







