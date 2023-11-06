use college;
show tables;

select * from Library;
select * from Library_Audit;
create table Library(
	book_id int unique primary key not null auto_increment,
    book_name varchar(255) default '',
    isbn int unique not null,
    page_count int,
    author varchar(255),
    year date,
    copies_sold int
);

create table Library_Audit(
	update_id int unique primary key auto_increment,
    book_id int,
    old_book_name varchar(255),
    old_isbn int unique not null,
    old_page_count int,
    old_author varchar(255),
    old_year date,
    old_copies_sold int
);

INSERT INTO Library VALUES 
	(1,'totam',14448882,425,'expedita','2023-03-19',43849117),
	(2,'voluptates',48822856,333,'sit','1974-08-27',11021007),
	(3,'quae',10721240,165,'voluptates','2011-05-06',72946253),
	(4,'impedit',77143556,133,'quam','1995-01-13',20492263),
	(5,'cum',57158171,667,'ipsa','2000-01-26',29278743),
	(6,'officia',23698255,804,'temporibus','2007-11-06',77006951),
	(7,'rerum',52692996,871,'numquam','2012-08-23',23321626),
	(8,'perspiciatis',80040097,697,'sunt','2006-05-02',80292082),
	(9,'voluptate',78591954,642,'voluptatem','1990-07-11',23638319),
	(10,'iure',37495366,644,'non','2020-03-08',59228850),
	(11,'repellendus',29416436,841,'in','1982-03-28',63717696),
	(12,'earum',14016995,778,'officia','1971-09-02',43033034),
	(13,'quasi',46762666,855,'magni','1973-04-12',22185173),
	(14,'nihil',12714950,583,'aspernatur','1991-07-24',83182555),
	(15,'perspiciatis',86876793,590,'cum','1979-03-02',89074976),
	(16,'qui',71512407,331,'maiores','2009-09-11',56650470),
	(17,'neque',31651442,511,'perspiciatis','1980-11-07',18051664),
	(18,'aut',77667078,386,'officia','1990-09-02',13554780),
	(19,'qui',67772169,114,'expedita','2006-01-31',35066713),
	(20,'quae',78427689,222,'quaerat','1992-07-22',54087575);


delimiter //
create trigger update_trig
before update on Library
for each row
begin
	insert into Library_Audit(book_id,old_book_name,old_isbn,old_page_count,old_author,old_year,old_copies_sold)
    values
    (old.book_id,old.book_name,old.isbn,old.page_count,old.author,old.year,old.copies_sold);
end //

delimiter ;
update Library
set book_name = 'haha totam' where book_id = 1;

update Library
set book_name = 'Deception Point' where book_id = 5;

delimiter //
create trigger error_trig
before update on Library
for each row
begin
	if NEW.book_name = OLD.book_name then
		signal sqlstate '45000'
        set message_text = 'Same value of the updated book!';
	end if;
end //



delimiter ;

update Library
set book_name = 'rerum' where book_id = 7;

drop table Library_Audit;