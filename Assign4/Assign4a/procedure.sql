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

delimiter //
CREATE PROCEDURE demo(IN roll_in int , IN b_name varchar(255))
BEGIN
DECLARE ldate date;
DECLARE fine_amount int;
DECLARE fduration int;

DECLARE exit handler for sqlstate '45000' SELECT 'Duration Outside Range' MESSAGE;
SELECT dateOfIssue into ldate FROM borrower WHERE (rollno = roll_in and bookname = b_name);

SET fduration = DATEDIFF(CURDATE() , ldate);

IF (fduration >= 15 and fduration <= 30) THEN
    SET fine_amount = fduration * 5;
ELSE IF (fduration > 30 and fduration <= 70) THEN
    SET fine_amount = fduration * 50;
ELSE
    signal sqlstate '45000';
END IF;
END IF;

UPDATE borrower SET bookStatus = 'R' WHERE (rollno = roll_in and bookname = b_name);
INSERT INTO fine(rollno , date_ , amount)
VALUES
(roll_in , CURDATE , fine_amount);

END
//



delimiter $$
create procedure demo(roll_in int , b_name varchar(20))
begin
declare ldate date;
declare fine_amt int(20);
declare f_duration int(20);
 declare exit handler for sqlstate '45000' select 'duration outside range' message;
select issue_date into ldate from borrower where (roll_no = roll_in and bookname = b_name);
set f_duration = DATEDIFF(CURDATE(), ldate);
if (f_duration >=15 and f_duration <= 30) then 
set fine_amt = f_duration * 5;
else if (f_duration >30 and f_duration<=70) then 
set fine_amt = f_duration * 50;
else 
signal sqlstate '45000';
end if;
end if;
update borrower set b_status = 'R' where (roll_no = roll_in and bookname = b_name);
insert into fine values (roll_in, CURDATE(), fine_amt);
end
$$