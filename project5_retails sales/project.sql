USE retail_db;
-- Create the Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Create the Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

-- Create the Sales table with Foreign Keys
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    customer_id INT,
    quantity INT,
    sale_date DATE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert 10 records into Products
INSERT INTO Products (product_name, category, price) VALUES
('Laptop', 'Electronics', 1200.00),
('Mouse', 'Electronics', 45.00),
('Keyboard', 'Electronics', 75.00),
('Monitor', 'Electronics', 300.00),
('Desk Chair', 'Furniture', 150.00),
('Standing Desk', 'Furniture', 400.00),
('Coffee Mug', 'Homeware', 15.00),
('Notebook', 'Office', 5.00),
('Pen Pack', 'Office', 10.00),
('Desk Lamp', 'Homeware', 25.00);

-- Insert 10 records into Customers
INSERT INTO Customers (customer_name, email) VALUES
('Alice Smith', 'alice@email.com'),
('Bob Johnson', 'bob@email.com'),
('Charlie Lee', 'charlie@email.com'),
('David Brown', 'david@email.com'),
('Emily White', 'emily@email.com'),
('Frank Green', 'frank@email.com'),
('Grace Hall', 'grace@email.com'),
('Henry King', 'henry@email.com'),
('Ivy Scott', 'ivy@email.com'),
('Jack Adams', 'jack@email.com');

-- Insert 12 records into Sales
INSERT INTO Sales (product_id, customer_id, quantity, sale_date) VALUES
(1, 1, 1, '2025-10-01'), -- Alice buys Laptop
(2, 1, 2, '2025-10-01'), -- Alice buys 2 Mice
(3, 2, 1, '2025-10-02'), -- Bob buys Keyboard
(5, 3, 1, '2025-10-03'), -- Charlie buys Desk Chair
(7, 4, 5, '2025-10-03'), -- David buys 5 Mugs
(8, 5, 10, '2025-10-04'), -- Emily buys 10 Notebooks
(9, 5, 2, '2025-10-04'), -- Emily buys 2 Pen Packs
(1, 6, 1, '2025-10-05'), -- Frank buys Laptop
(4, 7, 2, '2025-10-05'), -- Grace buys 2 Monitors
(6, 2, 1, '2025-10-06'), -- Bob buys Standing Desk
(10, 8, 1, '2025-10-07'), -- Henry buys Desk Lamp
(2, 1, 1, '2025-10-07'); -- Alice buys another Mouse

-- Query 1: Best-Selling Product (by quantity)
SELECT
    p.product_name,
    SUM(s.quantity) AS total_quantity_sold
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC;

-- Query 2: Total Sales per Category (by revenue)
SELECT
    p.category,
    SUM(s.quantity * p.price) AS total_revenue
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- Query 3: Average Purchase per Customer
SELECT
    c.customer_name,
    AVG(s.quantity * p.price) AS average_purchase_value
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
JOIN Customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY average_purchase_value DESC;

-- Query 4: Daily Sales Trends
SELECT
    s.sale_date,
    SUM(s.quantity * p.price) AS daily_revenue
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY s.sale_date
ORDER BY s.sale_date;