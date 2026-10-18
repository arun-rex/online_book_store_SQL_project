--SQL Project: Online Bookstore
--This project involves working with three CSV files, which you will import into Microsoft SQL Server. These files contain essential data required to perform various SQL queries.
use obs

select * from books
select * from customers
select * from orders

--Basic Queries
--1) Retrieve all books in the "Fiction" genre.
select * from books 
	where Genre ='fiction'

--2) Find books published after the year 1950.
select * from books 
	where Published>1950

--3) List all customers from the Canada.
select * from customers
	where Country='canada'

--4) Show orders placed in November 2023.
select * from orders
	where Order_Date between '2023-11-1' and '2023-11-30'

--5) Retrieve the total stock of books available.
select sum(stock) as total_stock from books

--6) Find the details of the most expensive book.
select top 1 * from books
	order by Price desc

--7) Show all customers who ordered more than 1 quantity of a book.
select * from orders
	where Quantity>1

--8) Retrieve all orders where the total amount exceeds $20.
select * from orders
	where Total_Amount>20

--9) List all genres available in the Books table.
select distinct Genre from books
	where stock >0

--10) Find the book with the lowest stock.
select top 10 * from books
	where stock >0
	order by stock asc

--11) Calculate the total revenue generated from all orders.
select sum(total_amount) as total_revenue from orders

--Advance Queries
--1) Retrieve the total number of books sold for each genre.
select b.Genre,SUM(o.Quantity) as sold_book from books as b
	inner join orders as o
	on o.Book_ID=b.Book_ID
	group by b.Genre

--2) Find the average price of books in the "Fantasy" genre.
select avg(price) as avg_price from books
	where Genre='fantasy'


--3) List customers who have placed at least 2 orders.
select c.Name,o.Customer_ID,count(*) as order_placed from orders as o
	inner join customers as c
	on c.Customer_ID=o.Customer_ID
	group by o.Customer_ID, c.Name
	having count(*)>=2

--4) Find the most frequently ordered book.
select top 10 b.Title,count(o.book_id) from orders as o
	inner join books as b
	on o.Book_ID=b.Book_ID
	group by b.Title
	order by count(o.book_id) desc

--5) Show the top 3 most expensive books of 'Fantasy' Genre.
select top 3 * from books
	where Genre='fantasy'
	order by Price desc

--6) Retrieve the total quantity of books sold by each author.
select author, sum(quantity) as total_quantity from books as b
	inner join orders as o
	on b.Book_ID=o.Book_ID
	group by Author

--7) List the cities where customers who spent over $30 are located.
select c.City,o.Total_Amount from customers as c
	inner join orders as o 
	on c.Customer_ID=o.Customer_ID
	where Total_Amount>30

--8) Find the customer who spent the most on orders.
select top 1 c.name,c.Customer_ID ,sum(total_amount) as most_spent from orders as o 
	inner join customers as c
	on o.Customer_ID=c.Customer_ID
	group by c.Customer_ID, c.Name
	order by most_spent desc

--9) Calculate the stock remaining after fulfilling all orders.
select b.Book_ID, b.Title, b.Stock, sum(isnull(o.Quantity,0)) as order_quantity,
	(b.Stock-sum(isnull(o.Quantity,0))) as remain from books as b
	left join orders as o
	on b.Book_ID=o.Book_ID
	group by b.Book_ID, b.Title, b.Stock
	order by b.Book_ID

--Instructions:
--Import all three CSV files into Microsoft SQL Server.
--Use the data to execute the above queries.
--Analyze the results and interpret the insights obtained.