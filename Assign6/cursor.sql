use college;
show tables;

-- Cursors: (All types: Implicit, Explicit, Cursor FOR Loop,
-- Parameterized Cursor)
-- Write a PL/SQL block of code using parameterized Cursor, that
-- will merge the data available in the newly created table
-- N_EmpId with the data available in the table O_EmpId.
-- If the data in the first table already exist in the second table then
-- that data should be skipped.

select * from O_EmpId;
select * from N_EmpId;

-- CREATION OF TABLES

CREATE TABLE N_EmpID ( 
	emp_id INT,
	dept_id INT,
	emp_fname VARCHAR(20),
	emp_lname VARCHAR(20),
	emp_position VARCHAR(50),
	emp_salary INT,
	emp_jdate DATE,
	PRIMARY KEY (emp_id)
);

CREATE TABLE O_EmpID ( 
	emp_id INT,
	dept_id INT,
	emp_fname VARCHAR(20),
	emp_lname VARCHAR(20),
	emp_position VARCHAR(50),
	emp_salary INT,
	emp_jdate DATE,
	PRIMARY KEY (emp_id)
);

-- INSERTING THE VALUES

INSERT INTO O_EmpID VALUES 
	(19,2,'molestiae','nostrum','quisquam',850067,'1990-02-16'),
	(23,2,'aut','quis','harum',313554,'1976-09-16'),
	(32,2,'et','et','architecto',942122,'1972-03-16'),
	(33,3,'voluptatem','at','rerum',731520,'1990-06-28'),
	(34,2,'fugit','harum','omnis',477917,'1985-08-06'),
	(36,1,'provident','voluptatem','at',145306,'1995-07-06'),
	(55,3,'suscipit','et','et',481782,'2011-05-10'),
	(59,1,'ea','temporibus','qui',861072,'1988-07-26'),
	(60,3,'fuga','quia','placeat',393128,'1988-10-12'),
	(63,1,'voluptatem','nihil','reiciendis',856496,'1986-10-27'),
	(67,3,'amet','expedita','similique',720147,'2000-11-24'),
	(69,1,'dolore','magni','eius',414471,'1972-11-21'),
	(70,2,'quos','veritatis','ex',938067,'1997-04-13'),
	(81,2,'sequi','aut','voluptatibus',120184,'1987-12-17'),
	(84,3,'ipsum','sunt','nemo',446727,'1977-03-24'),
	(91,1,'tempore','qui','quia',338584,'1992-07-24'),
	(110,1,'consequatur','ipsam','est',576805,'2001-04-22'),
	(111,2,'eveniet','assumenda','rerum',526825,'2006-04-23'),
	(123,3,'optio','esse','est',730407,'1989-06-18'),
	(138,2,'nihil','rerum','eum',311204,'2009-03-02'),
    (139,3,'krishna','patil','ceo',10000000,'2009-04-02');
    
INSERT INTO N_EmpID VALUES 
	(19,2,'molestiae','nostrum','quisquam',850067,'1990-02-16'),
	(23,2,'aut','quis','harum',313554,'1976-09-16'),
	(32,2,'et','et','architecto',942122,'1972-03-16'),
	(33,3,'voluptatem','at','rerum',731520,'1990-06-28'),
	(34,2,'fugit','harum','omnis',477917,'1985-08-06'),
	(36,1,'provident','voluptatem','at',145306,'1995-07-06'),
	(55,3,'suscipit','et','et',481782,'2011-05-10'),
	(165,1,'molestiae','itaque','dolorem',948514,'1975-08-09'),
	(168,2,'id','et','ut',771819,'2003-08-17'),
	(172,1,'iure','omnis','ut',486159,'2006-09-16'),
	(173,1,'perferendis','omnis','veniam',845958,'1990-07-14'),
	(174,2,'alias','debitis','aut',679066,'2014-04-10'),
	(179,2,'doloremque','voluptate','voluptate',148700,'1989-03-13'),
	(184,1,'sed','error','reiciendis',993787,'1971-11-13'),
	(186,1,'voluptas','eum','et',940556,'1983-09-08'),
	(195,2,'nesciunt','non','autem',215182,'2011-04-22'),
	(198,1,'pariatur','autem','deserunt',974698,'1972-04-24');
    
-- CREATING CURSORS

delimiter //
create procedure merge_tables()
begin
	declare done int default 0;
	declare eNo int;
	declare old_cursor cursor for select emp_id from O_EmpId;
    declare continue handler for not found set done = 1;
	open old_cursor;

	fetchdata: LOOP
		if done = 1 then
			leave fetchdata;
		end if;
        
        fetch old_cursor into eno;
        if not exists (select 1 from N_EmpId where emp_id = eno) then
			insert into N_EmpId
            select * from O_EmpId
            where emp_id = eno;
		end if;
	end LOOP;
    
    close old_cursor;
end //

call merge_tables;

delimiter //
create procedure merge_tables_within_bounds(IN lower_bound int , IN upper_bound int)
begin

	declare eno int;
    declare done int default 0;
	declare old_cursor1 cursor for select emp_id from O_EmpId where emp_id between lower_bound and upper_bound;
    declare continue handler for not found set done = 1;
    open old_cursor1;
    fetchdata: LOOP
		if done = 1 then
			leave fetchdata;
		end if;
        
        fetch old_cursor1 into eno;
        if not exists (select 1 from N_EmpId where emp_id = eno) then
			insert into N_EmpId
            select * from O_EmpId
            where O_EmpId.emp_id = eno;
		end if;
	end LOOP;
    
    close old_cursor1;

end //

call merge_tables_within_bounds(2,14);


drop procedure merge_tables_within_bounds;
drop table O_EmpId;