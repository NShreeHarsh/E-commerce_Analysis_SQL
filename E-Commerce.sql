CREATE DATABASE E-Commerce
USE E-Commerce   
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15),
    address TEXT
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Inventory_Logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    change_date DATE,
    change_amount INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert Customers
INSERT INTO Customers (name, email, phone_number, address)
VALUES
('John Doe', 'john.doe@example.com', '123-456-7890', '123 Elm St, NY'),
('Jane Smith', 'jane.smith@example.com', '987-654-3210', '456 Maple Ave, CA');

-- Insert Products
INSERT INTO Products (name, category, price, stock_quantity)
VALUES
('Laptop', 'Electronics', 1200.00, 50),
('Phone', 'Electronics', 800.00, 100),
('Headphones', 'Accessories', 150.00, 200);

-- Insert Orders
INSERT INTO Orders (customer_id, order_date, status)
VALUES
(1, '2025-01-01', 'Shipped'),
(2, '2025-01-02', 'Pending');

-- Insert Order Details
INSERT INTO Order_Details (order_id, product_id, quantity, subtotal)
VALUES
(1, 1, 1, 1200.00),
(1, 3, 2, 300.00),
(2, 2, 1, 800.00);

-- Insert Inventory Logs
INSERT INTO Inventory_Logs (product_id, change_date, change_amount)
VALUES
(1, '2025-01-01', -1),
(3, '2025-01-01', -2),
(2, '2025-01-02', -1);


SELECT SUM(subtotal) AS total_revenue
FROM Order_Details;

SELECT P.name, SUM(OD.quantity) AS total_sold
FROM Order_Details OD
JOIN Products P ON OD.product_id = P.product_id
GROUP BY P.name
ORDER BY total_sold DESC;

SELECT C.name, SUM(OD.subtotal) AS total_spent
FROM Customers C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Order_Details OD ON O.order_id = OD.order_id
GROUP BY C.name
ORDER BY total_spent DESC;

SELECT P.name, P.stock_quantity, SUM(OD.quantity) AS total_sold
FROM Products P
LEFT JOIN Order_Details OD ON P.product_id = OD.product_id
GROUP BY P.name, P.stock_quantity;




