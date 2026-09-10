CREATE DATABASE CustomerOrderManagementDB;
USE CustomerOrderManagementDB;

CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(120) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `Order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',

    updated_at TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

INSERT INTO Customer
(customer_name, email, phone)
VALUES
('Ananya Rao', 'ananya.rao@example.com', '9840012345'),
('Vikram Shah', 'vikram.shah@example.com', '9940098765'),
('Priya Menon', 'priya.menon@example.com', '9003345678'),
('Rahul Kumar', 'rahul.kumar@example.com', '9876543210'),
('Divya Sharma', 'divya.sharma@example.com', '9123456789');


INSERT INTO `Order`
(customer_id, order_date, amount, status)
VALUES
(1, '2026-07-02', 2098.00, 'DELIVERED'),
(1, '2026-07-20', 799.00, 'SHIPPED'),
(2, '2026-07-15', 650.00, 'DELIVERED'),
(3, '2026-08-01', 250.00, 'PENDING'),
(4, '2026-08-05', 1499.00, 'SHIPPED'),
(5, '2026-08-10', 899.00, 'PENDING');

SELECT * FROM Customer;

SELECT * FROM `Order`;

SELECT
    c.customer_id,
    c.customer_name,
    c.email,
    c.phone,
    o.order_id,
    o.order_date,
    o.amount,
    o.status
FROM Customer c
JOIN `Order` o
ON c.customer_id = o.customer_id;

INSERT INTO `Order`
(customer_id, order_date, amount, status)
VALUES
(2, '2026-08-15', 1499.00, 'PENDING');


UPDATE `Order`
SET status = 'SHIPPED'
WHERE order_id = 4;

UPDATE `Order`
SET amount = 2999.00
WHERE order_id = 5;

DELETE FROM `Order`
WHERE order_id = 6;

SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.amount,
    o.status
FROM Customer c
JOIN `Order` o
ON c.customer_id = o.customer_id
ORDER BY c.customer_name, o.order_date;


SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_spend
FROM Customer c
LEFT JOIN `Order` o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spend DESC;

SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.amount
FROM Customer c
JOIN `Order` o
ON c.customer_id = o.customer_id
WHERE o.status = 'PENDING'
ORDER BY c.customer_name;

SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.amount,
    o.status
FROM Customer c
JOIN `Order` o
ON c.customer_id = o.customer_id
WHERE o.status = 'DELIVERED';

SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.amount,
    o.status
FROM Customer c
JOIN `Order` o
ON c.customer_id = o.customer_id
WHERE o.status = 'SHIPPED';

SELECT
    order_id,
    customer_id,
    order_date,
    amount,
    status
FROM `Order`
WHERE amount > 1000
ORDER BY amount DESC;

SELECT
    MAX(amount) AS highest_order_amount
FROM `Order`;

SELECT
    MIN(amount) AS lowest_order_amount
FROM `Order`;

SELECT
    SUM(amount) AS total_sales
FROM `Order`;

SELECT
    AVG(amount) AS average_order_value
FROM `Order`;

SELECT
    COUNT(order_id) AS total_orders
FROM `Order`;

SELECT
    status,
    COUNT(order_id) AS total_orders,
    SUM(amount) AS total_amount
FROM `Order`
GROUP BY status
ORDER BY total_orders DESC;

SELECT
    c.customer_name,
    SUM(o.amount) AS total_spend
FROM Customer c
JOIN `Order` o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spend DESC
LIMIT 1;

SELECT DISTINCT
    c.customer_id,
    c.customer_name
FROM Customer c
JOIN `Order` o
ON c.customer_id = o.customer_id;

SELECT
    c.customer_id,
    c.customer_name
FROM Customer c
LEFT JOIN `Order` o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT
    c.customer_id,
    c.customer_name,
    c.email,
    o.order_id,
    o.order_date,
    o.amount,
    o.status
FROM Customer c
LEFT JOIN `Order` o
ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_date;

SELECT
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_sales,
    AVG(o.amount) AS average_order_value
FROM Customer c
LEFT JOIN `Order` o
ON c.customer_id = o.customer_id;



