E-Commerce Database Project

Overview

This project involves designing, implementing, and analyzing an e-commerce database to manage customer orders, products, inventory, and financial transactions. It demonstrates relational database management skills and SQL expertise, with integration into Python for analysis and Tableau for visualization.

Features

Database Schema:

Tables for Customers, Products, Orders, Order Details, and Inventory Logs.

Relationships defined via foreign keys.

Designed for scalability and efficiency.

Key Functionalities:

Track customer purchases and order details.

Monitor inventory levels and changes.

Perform revenue, sales, and customer segmentation analysis.

Integrations:

Python: Fetch and visualize data using libraries like Pandas, Matplotlib, and Seaborn.

Tableau: Build interactive dashboards to showcase insights.

Database Schema

1. Tables

Customers: Stores customer information.

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15),
    address TEXT
);

Products: Stores product details.

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT
);

Orders: Tracks customer orders.

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

Order_Details: Tracks products in each order.

CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

Inventory_Logs: Tracks inventory changes.

CREATE TABLE Inventory_Logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    change_date DATE,
    change_amount INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

SQL Queries

Total Revenue Calculation

SELECT SUM(subtotal) AS total_revenue
FROM Order_Details;

Top-Selling Products

SELECT P.name, SUM(OD.quantity) AS total_sold
FROM Order_Details OD
JOIN Products P ON OD.product_id = P.product_id
GROUP BY P.name
ORDER BY total_sold DESC;

Customer Segmentation by Spending

SELECT C.name, SUM(OD.subtotal) AS total_spent
FROM Customers C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Order_Details OD ON O.order_id = OD.order_id
GROUP BY C.name
ORDER BY total_spent DESC;

Inventory Forecasting
SELECT P.name, P.stock_quantity, SUM(OD.quantity) AS total_sold
FROM Products P
LEFT JOIN Order_Details OD ON P.product_id = OD.product_id
GROUP BY P.name, P.stock_quantity;
