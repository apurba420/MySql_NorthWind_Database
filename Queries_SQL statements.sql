-- Q1.Write a query to get Product list (name, unit price) of ten most expensive products.

SELECT ProductName,UnitPrice
From Products
ORDER BY UnitPrice DESC LIMIT 10;


-- Q3.Find out the quartely orders for each product for the year 1997?

SELECT a.ProductName, 
    year(OrderDate) as OrderYear,
    format(sum(case quarter(c.OrderDate) when '1' 
        then b.UnitPrice*b.Quantity*(1-b.Discount) else 0 end), 0) "Qtr 1",
    format(sum(case quarter(c.OrderDate) when '2' 
        then b.UnitPrice*b.Quantity*(1-b.Discount) else 0 end), 0) "Qtr 2",
    format(sum(case quarter(c.OrderDate) when '3' 
        then b.UnitPrice*b.Quantity*(1-b.Discount) else 0 end), 0) "Qtr 3",
    format(sum(case quarter(c.OrderDate) when '4' 
        then b.UnitPrice*b.Quantity*(1-b.Discount) else 0 end), 0) "Qtr 4" 
FROM Products a 
INNER JOIN OrdersDetails b on a.ProductID = b.ProductID
INNER JOIN Orders c on c.OrderID = b.OrderID
INNER JOIN Customers d on d.CustomerID = c.CustomerID 
WHERE c.OrderDate between date('1997-01-01') and date('1997-12-31')
GROUP BY a.ProductName, 
    year(OrderDate)
ORDER BY a.ProductName;


-- Q4.Give the name of employees and the city where they live for employees who have sold to customers in the same city?

SELECT DISTINCT a.FirstName, a.LastName, a.City
FROM Employees a, Orders b
JOIN Customers c on b.CustomerID = c.CustomerID
WHERE a.City = c.City;


-- Q5.Give the names of employees who are strictly older than any employee who lives in London?

SELECT FirstName, LastName
FROM Employees 
WHERE BirthDate < 
(SELECT MIN(BirthDate)
FROM Employees
WHERE City='London')
;

