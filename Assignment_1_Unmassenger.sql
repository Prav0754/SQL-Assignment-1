/*Basic Question */
/* 1.1 */
USE org;

SELECT * FROM customers;

/* 1.2 */
SELECT Name FROM products
WHERE Category = "Electronics";

/* 1.3 */
SELECT COUNT(OrderDate) AS Total_Order
FROM orders;

/* 1.4 */
SELECT * FROM orders
ORDER BY OrderDate DESC
LIMIT 3; -- SHOWING RECENTLY 3 ORDERS ---

/*Join and Relationship */
/* 2.1 */
SELECT p.Name AS Product_Name, c.Name AS Customer_Name 
FROM products AS p
JOIN orderdetails AS ord 
ON p.ProductID = ord.ProductID
JOIN orders AS o 
ON o.OrderID = ord.OrderID
JOIN customers AS c 
ON c.CustomerID = o.CustomerID;

/* 2.2 */
SELECT OrderID, COUNT(ProductID) AS Quantity
FROM orderdetails
GROUP BY OrderID
ORDER BY Quantity DESC
LIMIT 1;

/* 2.3 */
SELECT name AS Customer_Name, SUM(TotalAmount) AS Total_Sales FROM customers AS c
JOIN orders AS o
ON o.CustomerID = c.CustomerID
GROUP BY name;

/* Aggregation and Grouping */
/* 3.1 */
SELECT p.Category AS Product_Category, SUM(O.TotalAmount) AS Total_Amount
FROM products AS p
JOIN orderdetails AS ord
ON p.ProductID = ord.ProductID
JOIN orders AS o
ON o.OrderID = ord.OrderID
GROUP BY p.Category;

/* 3.2 */
SELECT AVG(TotalAmount) AS AVG_Order_Value
FROM orders;

/* 3.3 */
SELECT MONTHNAME(OrderDate) AS Month_Name, COUNT(OrderID) AS No_of_Order FROM orders
GROUP BY MONTHNAME(OrderDate);

/* Subqueries and Nested Queries */
/* 4.1 */
SELECT customers.Name FROM customers
WHERE customers.Name NOT IN (SELECT customers.Name
FROM customers
JOIN orders ON orders.CustomerID = customers.CustomerID);

/* 4.2 */
SELECT Name FROM products
WHERE Name NOT IN (SELECT Name FROM products as p
JOIN orderdetails AS ord
ON ord.ProductID = p.ProductID
Group By Name);

/* 4.3 */

SELECT Name AS Product_Name, SUM(Quantity) AS Quantity_Sold FROM products AS p
JOIN orderdetails AS ord
ON ord.ProductID = p.ProductID
GROUP BY name
ORDER BY SUM(Quantity) DESC
LIMIT 3;

/* Date and Time Functions */
/* 5.1 */
SELECT MONTHNAME(OrderDate), products.Name, orders.TotalAmount FROM orders
JOIN orderdetails ON orderdetails.OrderID = orders.OrderID
JOIN products ON products.ProductID = orderdetails.ProductID
GROUP BY MONTHNAME(OrderDate), products.Name, orders.TotalAmount
ORDER BY MONTHNAME(OrderDate) DESC;

/* 5.2 */
SELECT Name, JoinDate FROM customers
ORDER BY JoinDate
LIMIT 1;

/* Advanced Queries */
/* 6.1 */
SELECT c.CustomerID, c.Name, o.TotalAmount, Rank() OVER (ORDER BY SUM(o.TotalAmount) DESC) AS Customer_Rank
FROM customers AS c
JOIN orders AS o ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.Name, o.TotalAmount
ORDER BY Customer_Rank;

/* 6.2 */
SELECT p.Name AS Prodcut_Name, SUM(ord.Quantity) AS Quantity_Sold
FROM orderdetails AS ord
JOIN products AS p
ON p.ProductID = ord.ProductID
GROUP BY p.Name
ORDER BY SUM(ord.Quantity) DESC
LIMIT 1;

/* 6.3 */
SELECT current_month.month, current_month.sales AS current_month_sales,
    previous_month.sales AS previous_month_sales,
    ROUND((current_month.sales - previous_month.sales) / previous_month.sales * 100,2) AS growth_rate
FROM
	(SELECT YEAR(OrderDate) AS year,month(OrderDate) AS month,
        SUM(TotalAmount) AS sales
    FROM orders
    GROUP BY 
        YEAR(OrderDate), month(OrderDate)) AS current_month
JOIN 
    (SELECT 
		YEAR(OrderDate) AS year,
        month(OrderDate) AS month,
        SUM(TotalAmount) AS sales
    FROM orders
    GROUP BY 
        YEAR(OrderDate), month(OrderDate)) AS previous_month
ON current_month.year = previous_month.year
    AND current_month.month = previous_month.month + 1;

/* Data Manipulation and Update */
/* 7.1 */
INSERT INTO customers
VALUES
(11, 'Jaspreet Singh', 'jaspreetsingh@example.com', '2020-04-11');

/* 7.2 */
UPDATE products
SET Price = 899.99
WHERE Name = "Laptop";
