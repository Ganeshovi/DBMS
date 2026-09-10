CREATE DATABASE LibraryManagementDB1;
USE LibraryManagementDB1;

CREATE TABLE Member (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15)
);


CREATE TABLE Book (
    book_id INT PRIMARY KEY,
    book_name VARCHAR(150) NOT NULL,
    author VARCHAR(100),
    category VARCHAR(50)
);

CREATE TABLE Borrow (
    borrow_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    issue_date DATE,
    return_date DATE,
    status VARCHAR(20),
    fine_amount DECIMAL(10,2),

    FOREIGN KEY (member_id)
        REFERENCES Member(member_id),

    FOREIGN KEY (book_id)
        REFERENCES Book(book_id)
);

INSERT INTO Member
(member_id, member_name, email, phone)
VALUES
(1, 'Arun Kumar', 'arun@gmail.com', '9876543210'),
(2, 'Priya Sharma', 'priya@gmail.com', '9876543211'),
(3, 'Karthik Raj', 'karthik@gmail.com', '9876543212'),
(4, 'Sneha Devi', 'sneha@gmail.com', '9876543213'),
(5, 'Rahul Das', 'rahul@gmail.com', '9876543214');


INSERT INTO Book
(book_id, book_name, author, category)
VALUES
(101, 'Python Programming', 'Mark Lutz', 'Programming'),
(102, 'Database System Concepts', 'Abraham Silberschatz', 'Database'),
(103, 'Artificial Intelligence', 'Stuart Russell', 'AI'),
(104, 'Web Development Basics', 'Jon Duckett', 'Web'),
(105, 'Data Structures', 'Seymour Lipschutz', 'Computer Science'),
(106, 'Machine Learning', 'Tom Mitchell', 'AI');


INSERT INTO Borrow
(borrow_id, member_id, book_id, issue_date,
 return_date, status, fine_amount)
VALUES
(1001, 1, 101, '2026-08-10', '2026-08-15', 'Returned', 0.00),
(1002, 2, 102, '2026-08-11', NULL, 'Issued', 0.00),
(1003, 1, 105, '2026-08-12', '2026-08-18', 'Returned', 20.00),
(1004, 3, 106, '2026-08-13', NULL, 'Issued', 0.00),
(1005, 4, 103, '2026-08-14', '2026-08-20', 'Returned', 0.00);


SELECT * FROM Member;

SELECT * FROM Book;

SELECT * FROM Borrow;

UPDATE Borrow
SET status = 'Returned',
    return_date = '2026-08-25'
WHERE borrow_id = 1002;

UPDATE Borrow
SET fine_amount = 30.00
WHERE borrow_id = 1004;

SELECT
    Member.member_name,
    Borrow.borrow_id,
    Book.book_name,
    Book.author,
    Borrow.issue_date,
    Borrow.return_date,
    Borrow.status,
    Borrow.fine_amount
FROM Member
JOIN Borrow
    ON Member.member_id = Borrow.member_id
JOIN Book
    ON Borrow.book_id = Book.book_id
ORDER BY Borrow.issue_date;
