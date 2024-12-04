CREATE DATABASE Library;
USE Library;

CREATE TABLE Branch (
	Branch_no int primary key,
	Manager_id int,
    Branch_address varchar(100),
    Contact_no varchar(12));

    
CREATE TABLE Employee (
	Emp_id int primary key,
    Emp_name varchar(100),
    Position varchar(100),
    Salary int,
    Branch_no int, 
    foreign key (branch_no) references Branch(Branch_no));
    
CREATE TABLE Books	(
	ISBN int primary key,
    Book_title varchar(100),
    Category varchar(100),
    Rental_price decimal(10,2),
    Status varchar(3) check (status IN('yes','no')),
    Author varchar(100),
    Publisher varchar(100));

CREATE TABLE Customer (
	Customer_id int primary key,
    Customer_name varchar(100),
    Customer_address varchar(100),
    Reg_date date);
    
CREATE TABLE IssueStatus (
	Issue_id int primary key,
    Issued_cust int,
    Issued_book_name varchar(100),
    Issue_date date,
    Isbn_book int,
    foreign key (Issued_cust) references Customer(Customer_id),
    foreign key (Isbn_book) references Books(ISBN));
    
CREATE TABLE ReturnStatus (
	Return_id int primary key,
    Return_cust int,
    Return_book_name varchar(100),
    Return_date date,
    Isbn_book2 int,
    foreign key (Return_cust) references Customer(customer_id),
    foreign key (Isbn_book2) references Books(ISBN));
    
SHOW TABLES;

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(101, 1, 'Main Street, City A', '9876543210'),
(102, 2, 'Elm Road, City B', '8765432109'),
(103, 3, 'Oak Avenue, City C', '7654321098'),
(104, 4, 'Maple Lane, City D', '6543210987');

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(1, 'John Smith', 'Manager', 75000, 101),
(2, 'Mary Johnson', 'Manager', 72000, 102),
(3, 'Robert Brown', 'Manager', 70000, 103),
(4, 'Linda Davis', 'Manager', 68000, 104),
(5, 'James Wilson', 'Assistant', 45000, 101),
(6, 'Karen Miller', 'Librarian', 55000, 102),
(7, 'David Moore', 'Assistant', 48000, 103),
(8, 'Susan Taylor', 'Librarian', 52000, 104),
(9, 'George King', 'Assistant', 46000, 101),
(10, 'Henry Queen', 'Clerk', 40000, 101),
(11, 'Lucy Prince', 'Assistant', 47000, 101),
(12, 'Michael Bishop', 'Clerk', 41000, 101),
(13, 'Emma Duke', 'Assistant', 49000, 101),
(14, 'Sophia Baron', 'Assistant', 45000, 102),
(15, 'Olivia Count', 'Clerk', 42000, 102),
(16, 'Liam Marquess', 'Assistant', 44000, 102),
(17, 'Mia Earl', 'Assistant', 43000, 102),
(18, 'Noah Knight', 'Clerk', 40000, 102);

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
(1001, 'History of Time', 'History', 30, 'yes', 'Stephen Hawking', 'Penguin Books'),
(1002, 'Advanced Physics', 'Science', 40, 'no', 'Albert Einstein', 'Springer'),
(1003, 'Basic Mathematics', 'Math', 20, 'yes', 'John Doe', 'McGraw Hill'),
(1004, 'Fictional World', 'Fiction', 25, 'yes', 'Jane Austen', 'Oxford Press'),
(1005, 'World History', 'History', 35, 'no', 'Eric Hobsbawm', 'Cambridge Press'),
(1006, 'Modern Chemistry', 'Science', 30, 'yes', 'Linus Pauling', 'Wiley'),
(1007, 'The Art of Coding', 'Tech', 50, 'no', 'Alan Turing', 'MIT Press'),
(1008, 'Fantasy Chronicles', 'Fiction', 20, 'yes', 'J.K. Rowling', 'Bloomsbury');


INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(201, 'Alice Green', '10 Main Street', '2021-10-01'),
(202, 'Bob White', '15 Elm Road', '2022-05-20'),
(203, 'Charlie Black', '25 Oak Avenue', '2023-01-15'),
(204, 'Daisy Blue', '30 Maple Lane', '2021-12-10'),
(205, 'Eve Red', '12 Hill Street', '2020-07-25');

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(301, 201, 'History of Time', '2023-06-05', 1001),
(302, 202, 'World History', '2023-06-10', 1005),
(303, 203, 'Advanced Physics', '2023-07-01', 1002),
(304, 201, 'The Art of Coding', '2023-06-20', 1007);

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(401, 201, 'History of Time', '2023-07-01', 1001),
(402, 202, 'World History', '2023-07-10', 1005),
(403, 203, 'Advanced Physics', '2023-08-01', 1002);

-- Q1
SELECT Book_title,Category,rental_price FROM Books 
WHERE Status = 'yes';

-- Q2
SELECT Emp_name,salary FROM Employee
ORDER BY salary DESC;

-- Q3
SELECT I.Issued_book_name,C.Customer_id,C.Customer_name 
FROM IssueStatus I
JOIN Customer C ON I.Issued_cust = C.Customer_Id;

-- Q4
SELECT Category,count(Category) AS BOOK_COUNT FROM Books
GROUP BY Category;

-- Q5
SELECT Emp_name,position,salary FROM Employee WHERE Salary > 50000;

-- Q6
SELECT Customer_name FROM Customer
WHERE Reg_date < '2022-01-01' 
AND Customer_id NOT IN (SELECT Issued_cust FROM IssueStatus);

-- Q7
SELECT Branch_no,count(*) FROM Employee
GROUP BY Branch_no;

-- Q8
SELECT DISTINCT C.customer_name 
FROM Customer C JOIN IssueStatus I ON C.Customer_id = I.Issued_cust
WHERE I.Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

-- Q9
SELECT Book_title FROM Books
WHERE Book_title LIKE '%history%';

-- Q10
SELECT Branch_no,count(*) FROM Employee
GROUP BY Branch_no
HAVING count(*) >5;

-- Q11
SELECT E.emp_name,B.Branch_address 
FROM Employee E Join Branch B ON E.emp_id = B.manager_id;

-- Q12
SELECT  C.customer_name,B.Book_title,B.Rental_price FROM Customer C 
JOIN IssueStatus I ON C.Customer_id = I.Issued_cust JOIN Books B ON I.Isbn_book = B.ISBN 
WHERE Rental_price > 25;  