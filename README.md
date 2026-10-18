# 📚 Online Bookstore – SQL Project

A beginner-to-intermediate SQL project built on **Microsoft SQL Server**. It uses three related datasets (books, customers, orders) from an online bookstore and answers business questions using filtering, aggregation, joins, grouping, and subtotal-style calculations.

---

## 🗂️ Repository Structure

| File | Description |
|------|-------------|
| `Books.csv` | Book catalogue – title, author, genre, published year, price, stock |
| `Customers.csv` | Customer details – name, email, phone, city, country |
| `Orders.csv` | Order records – customer, book, order date, quantity, total amount |
| `Schema.png` | Schema / ER diagram showing how the three tables relate |
| `Questions.txt` | The list of questions solved in this project |
| `My_Solution.sql` | My own solution to all questions |
| `Mentor_Solution.sql` | Reference solution provided by my mentor |

> ⚠️ Rename the files above to match the actual file names in your repo.

---

## 🧱 Database Schema

The database is named `obs` and contains three tables:

- **books** – `Book_ID`, `Title`, `Author`, `Genre`, `Published`, `Price`, `Stock`
- **customers** – `Customer_ID`, `Name`, `Email`, `Phone`, `City`, `Country`
- **orders** – `Order_ID`, `Customer_ID`, `Book_ID`, `Order_Date`, `Quantity`, `Total_Amount`

**Relationships**
- `orders.Customer_ID` → `customers.Customer_ID`
- `orders.Book_ID` → `books.Book_ID`

See `Schema.png` for the visual diagram.

---

## ⚙️ Setup Instructions

1. Open **SQL Server Management Studio (SSMS)**.
2. Create the database:
   ```sql
   CREATE DATABASE obs;
   USE obs;
   ```
3. Import the three CSV files using **Tasks → Import Flat File** (right-click the database), naming the tables `books`, `customers`, and `orders`.
4. Check that column data types are correct (e.g. `Order_Date` as `date`, `Price` and `Total_Amount` as numeric).
5. Open a solution file and run the queries.

---

## ❓ Questions Solved

### 🔹 Basic Queries
1. Retrieve all books in the "Fiction" genre.
2. Find books published after the year 1950.
3. List all customers from Canada.
4. Show orders placed in November 2023.
5. Retrieve the total stock of books available.
6. Find the details of the most expensive book.
7. Show all customers who ordered more than 1 quantity of a book.
8. Retrieve all orders where the total amount exceeds $20.
9. List all genres available in the Books table.
10. Find the book with the lowest stock.
11. Calculate the total revenue generated from all orders.

### 🔹 Advanced Queries
1. Retrieve the total number of books sold for each genre.
2. Find the average price of books in the "Fantasy" genre.
3. List customers who have placed at least 2 orders.
4. Find the most frequently ordered book.
5. Show the top 3 most expensive books of the "Fantasy" genre.
6. Retrieve the total quantity of books sold by each author.
7. List the cities where customers who spent over $30 are located.
8. Find the customer who spent the most on orders.
9. Calculate the stock remaining after fulfilling all orders.

---

## 🛠️ SQL Concepts Used

- `SELECT`, `WHERE`, `ORDER BY`, `TOP`, `DISTINCT`
- `BETWEEN` for date range filtering
- Aggregate functions: `SUM()`, `AVG()`, `COUNT()`
- `INNER JOIN` and `LEFT JOIN`
- `GROUP BY` and `HAVING`
- `ISNULL()` for handling missing values
- Aliases for readable output

---

## 💡 Sample Query

**Stock remaining after fulfilling all orders**

```sql
SELECT b.Book_ID, b.Title, b.Stock,
       SUM(ISNULL(o.Quantity, 0)) AS order_quantity,
       (b.Stock - SUM(ISNULL(o.Quantity, 0))) AS remain
FROM books AS b
LEFT JOIN orders AS o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock
ORDER BY b.Book_ID;
```

A `LEFT JOIN` is used so books that have never been ordered still appear with their full stock.

---

## 📊 Key Insights

> Fill this in after running the queries with your actual results.

- **Total revenue:** _your value_
- **Best-selling genre:** _your value_
- **Most frequently ordered book:** _your value_
- **Top-spending customer:** _your value_
- **Books with lowest remaining stock:** _your value_

---

## 🔍 My Solution vs Mentor Solution

Both solution files answer the same questions. Comparing them helped me learn alternative approaches, such as different ways to filter dates, handle duplicates, and structure joins.

---

## 🚀 How to Use This Repo

1. Clone the repository.
2. Import the CSV files into SQL Server as described above.
3. Run `Arun obs.sql` or `OnlineBookStore.sql` in SSMS.
4. Compare outputs and explore further.

---

## 👤 Author

**Arun**
Data & Accounts Analyst | Excel · SQL · Python · Power BI

Feel free to fork this repo, suggest improvements, or reach out with feedback.
