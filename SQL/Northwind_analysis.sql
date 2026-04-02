/*Q1: Total revenue by product category, sorted highest to lowest
Logic:
Joined Order Details with Products and Categories
Revenue = UnitPrice * Quantity * (1 - Discount)
Grouped by CategoryName
*/

SELECT 
    c.CategoryName,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalRevenue
FROM [Order Details] od
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY TotalRevenue DESC;

/*
Q2: Top 10 customers by lifetime order value, with their most recent order date
Logic:
Joined Customers, Orders, and Order Details to link customers with purchases.
Calculated total revenue per customer using SUM().
Used MAX(OrderDate) to get most recent order date.
Sorted by revenue and selected TOP 10 customers.
*/
SELECT TOP 10
    cu.CustomerID,
    cu.CompanyName,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS LifetimeValue,
    MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers cu
JOIN Orders o ON cu.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY cu.CustomerID, cu.CompanyName
ORDER BY LifetimeValue DESC;

/*
Q3: All orders where the shipped date was more than 7 days after the order date — flag these as delayed
Logic:
Calculated delay using DATEDIFF between OrderDate and ShippedDate.
Filtered orders where delay is greater than 7 days.
Used CASE to label orders as 'Delayed' or 'On Time'.
Returned relevant order details with delay information.
*/

SELECT 
    o.OrderID,
    o.CustomerID,
    o.OrderDate,
    o.ShippedDate,
    DATEDIFF(DAY, o.OrderDate, o.ShippedDate) AS ShippingDelayDays,
    CASE 
        WHEN DATEDIFF(DAY, o.OrderDate, o.ShippedDate) > 7 THEN 'Delayed'
        ELSE 'On Time'
    END AS Status
FROM Orders o
WHERE DATEDIFF(DAY, o.OrderDate, o.ShippedDate) > 7;

/*STORED PROCEDURE: Customer Lifetime Value
Logic:
Created a stored procedure to fetch top N customers by lifetime value.
Accepted @TopN as input parameter to control number of results.
Joined Customers, Orders, and Order Details and calculate revenue using SUM().
Sorted by revenue in descending order and returned top N customers.
*/
CREATE PROCEDURE GetTopCustomers
    @TopN INT = 10
AS
BEGIN
    SELECT TOP (@TopN)
        cu.CustomerID,
        cu.CompanyName,
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS LifetimeValue,
        MAX(o.OrderDate) AS MostRecentOrderDate
    FROM Customers cu
    JOIN Orders o ON cu.CustomerID = o.CustomerID
    JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY cu.CustomerID, cu.CompanyName
    ORDER BY LifetimeValue DESC;
END;

-- Execution

EXEC GetTopCustomers @TopN = 10;
