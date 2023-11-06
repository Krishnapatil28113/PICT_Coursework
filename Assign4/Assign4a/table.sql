-- Unnamed PL/SQL code block: Use of Control structure
-- and Exception handling is mandatory. Write a PL/SQL
-- block of code for the following requirements:-
-- Schema:
-- 1. Borrower(Roll,Name,DateofIssue, NameofBook, Status)
-- 2. Fine (Roll, Date, Amt)
-- Accept Roll & Name of book from user.
-- Check the number of days (from date of issue), if days
-- are between 15 to 30 then fine amount will be Rs 5per day.
-- If no. of days>30, per day fine will be Rs 50 per day &
-- for days less than 30, Rs. 5 per day.
-- After submitting the book, status will change from I to R.
-- If condition of fine is true, then details will be stored into
-- fine table.
-- Frame the problem statement for writing PL/SQL block
-- inline with above statement.

CREATE TABLE borrower(rollno int PRIMARY KEY NOT NULL , name_ varchar(255) , dateOfIssue date , bookname varchar(255) , bookStatus varchar(20));
CREATE TABLE fine(rollno int , date_ date , amount int);

INSERT INTO borrower
VALUES
(1,"Krishna","2023-08-24","DBMS","I"),
(2,"Ameya","2023-08-25","TOC","I"),
(3,"Tejas","2023-08-26","CNS","I"),
(4,"Shantanu","2023-08-27","SPOS","I");