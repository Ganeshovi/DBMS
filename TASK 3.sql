CREATE DATABASE store_inventory_db5;
USE store_inventory_db5;

CREATE TABLE Seller (
    seller_id INT PRIMARY KEY,
    seller_name VARCHAR(60),
    city VARCHAR(40),
    phone VARCHAR(15)
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(60),
    category VARCHAR(40),
    unit_price DECIMAL(10,2),
    seller_id INT,

    FOREIGN KEY (seller_id)
        REFERENCES Seller(seller_id)
);

CREATE TABLE Inventory (
    stock_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    reorder_level INT,
    stock_status VARCHAR(20),

    FOREIGN KEY (product_id)
        REFERENCES Product(product_id)
);

INSERT INTO Seller VALUES
(101, 'Nova Digital Supplies', 'Chennai', '9001122334'),
(102, 'Bright Office Hub', 'Coimbatore', '9012233445'),
(103, 'Metro Gadget House', 'Madurai', '9023344556'),
(104, 'Prime Tech Stores', 'Salem', '9034455667');


INSERT INTO Product VALUES
(301, 'Laser Keyboard', 'Accessories', 1250.00, 101),
(302, 'USB Microphone', 'Audio', 2450.00, 102),
(303, 'Wi-Fi Router', 'Networking', 3200.00, 103),
(304, 'LED Monitor 24', 'Display', 8900.00, 104),
(305, 'Wireless Mouse', 'Accessories', 850.00, 101);

INSERT INTO Inventory VALUES
(501, 301, 25, 10, 'In Stock'),
(502, 302, 7, 8, 'Reorder'),
(503, 303, 18, 5, 'In Stock'),
(504, 304, 3, 5, 'Reorder'),
(505, 305, 40, 15, 'In Stock');

SELECT *
FROM Seller;

SELECT product_name, category, unit_price
FROM Product;

SELECT
    Seller.seller_name,
    Product.product_name,
    Product.unit_price
FROM Seller
INNER JOIN Product
    ON Seller.seller_id = Product.seller_id;
    
    
    SELECT
    Product.product_name,
    Inventory.quantity,
    Inventory.reorder_level
FROM Product
INNER JOIN Inventory
    ON Product.product_id = Inventory.product_id
WHERE Inventory.stock_status = 'Reorder';

SELECT
    Product.product_name,
    Inventory.quantity
FROM Product
INNER JOIN Inventory
    ON Product.product_id = Inventory.product_id
WHERE Inventory.quantity > 20;



SELECT
    Product.product_id,
    Product.product_name,
    Product.category,
    Inventory.quantity,
    Inventory.reorder_level,
    Inventory.stock_status
FROM Product
INNER JOIN Inventory
    ON Product.product_id = Inventory.product_id;
    
    
    SELECT
    SUM(Product.unit_price * Inventory.quantity)
    AS total_inventory_value
FROM Product
INNER JOIN Inventory
    ON Product.product_id = Inventory.product_id;
    
   UPDATE Inventory
SET
    quantity = 55,
    stock_status = 'In Stock'
WHERE product_id = 305;

SELECT *
FROM Inventory
WHERE product_id = 305;

DELETE FROM Inventory
WHERE product_id = 304;

DELETE FROM Product
WHERE product_id = 304;


SELECT
    Product.product_id,
    Product.product_name,
    Product.category,
    Product.unit_price,
    Seller.seller_name,
    Seller.city,
    Inventory.quantity,
    Inventory.reorder_level,
    Inventory.stock_status
FROM Product
INNER JOIN Seller
    ON Product.seller_id = Seller.seller_id
INNER JOIN Inventory
    ON Product.product_id = Inventory.product_id;







