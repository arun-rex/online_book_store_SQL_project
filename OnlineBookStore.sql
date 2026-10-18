-- Create Database
CREATE DATABASE OnlineBookstore
USE OnlineBookStore

-- Create Table and Drop tables if they exist
IF OBJECT_ID('Orders', 'U') IS NOT NULL
DROP TABLE Orders
IF OBJECT_ID('Customers', 'U') IS NOT NULL
DROP TABLE Customers
IF OBJECT_ID('Books', 'U') IS NOT NULL
DROP TABLE Books

-- Create Books table
CREATE TABLE Books (
Book_ID INT PRIMARY KEY,
Title VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(50),
Published_Year INT,
Price DECIMAL(10, 2),
Stock INT
)

-- Create Customers table
CREATE TABLE Customers (
Customer_ID INT PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15),
City VARCHAR(50),
Country VARCHAR(150)
)

-- Create Orders table
CREATE TABLE Orders (
Order_ID INT PRIMARY KEY,
Customer_ID INT REFERENCES Customers(Customer_ID),
Book_ID INT REFERENCES Books(Book_ID),
Order_Date DATE,
Quantity INT,
Total_Amount DECIMAL(10, 2)
)

-- Import Data into Books Table
BULK INSERT Books
FROM 'C:\Users\arjun\OneDrive\Desktop\SQL\Projects\P1\Books.csv'
WITH (
FIELDTERMINATOR = ',',  -- CSV field delimiter
ROWTERMINATOR = '\n',   -- Row delimiter
FIRSTROW = 2 -- Skip the header row (if your CSV has headers)
)

-- Import Data into Customers Table
BULK INSERT Customers
FROM 'C:\Users\arjun\OneDrive\Desktop\SQL\Projects\P1\Customers.csv'
WITH (
FIELDTERMINATOR = ',',  -- CSV field delimiter
ROWTERMINATOR = '\n',   -- Row delimiter
FIRSTROW = 2-- Skip the header row (if your CSV has headers)
)

-- Import Data into Orders Table
BULK INSERT Orders
FROM 'C:\Users\arjun\OneDrive\Desktop\SQL\Projects\P1\Orders.csv'
WITH (
FIELDTERMINATOR = ',',  -- CSV field delimiter
ROWTERMINATOR = '\n',   -- Row delimiter
FIRSTROW = 2-- Skip the header row (if your CSV has headers)
)

SELECT * FROM Books
SELECT * FROM Customers
SELECT * FROM Orders

-- BASIC QUERIES
-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM Books 
WHERE Genre='Fiction'

-- 2) Find books published after the year 1950:
SELECT * FROM Books 
WHERE Published_year>1950

-- 3) List all customers from the Canada:
SELECT * FROM Customers 
WHERE country='Canada'


-- 4) Show orders placed in November 2023:

SELECT * FROM Orders 
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30'

-- 5) Retrieve the total stock of books available:

SELECT SUM(stock) AS Total_Stock
From Books


-- 6) Find the details of the most expensive book:
SELECT TOP 1 * FROM Books 
ORDER BY Price DESC



-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders 
WHERE quantity>1



-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders 
WHERE total_amount>20



-- 9) List all genres available in the Books table:
SELECT DISTINCT genre FROM Books


-- 10) Find the book with the lowest stock:
SELECT TOP 1 * FROM Books 
ORDER BY stock 



-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) As Revenue 
FROM Orders

-- Advance Questions : 
-- 1) Retrieve the total number of books sold for each genre:
SELECT b.Genre, SUM(o.Quantity) AS Total_Books_sold
FROM Orders o
INNER JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre


-- 2) Find the average price of books in the "Fantasy" genre:
SELECT AVG(price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy'


-- 3) List customers who have placed at least 2 orders:
SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
INNER JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=2




-- 4) Find the most frequently ordered book:
SELECT TOP 1 o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
INNER JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC 



-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT TOP 3 * FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC 


-- 6) Retrieve the total quantity of books sold by each author:
SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
INNER JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author

-- 7) List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.city, total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30

-- 8) Find the customer who spent the most on orders:
SELECT TOP 1 c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc


--9) Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id, b.title, b.stock, 
SUM(o.quantity) AS Order_quantity,  
b.stock - SUM(o.quantity) AS Remaining_Quantity
FROM books b LEFT JOIN orders o 
ON b.book_id = o.book_id
GROUP BY b.book_id, b.title,  b.stock
ORDER BY b.book_id

SELECT b.book_id, b.title, b.stock, 
COALESCE(SUM(o.quantity), 0) AS Order_quantity,  
b.stock - COALESCE(SUM(o.quantity), 0) AS Remaining_Quantity
FROM books b LEFT JOIN orders o 
ON b.book_id = o.book_id
GROUP BY b.book_id, b.title,  b.stock
ORDER BY b.book_id









