/* 
Create tables

Assignment No 2A  (Student Schema)
Consider the following relational Schema.  
 Student( s_id,Drive_id,T_id,s_name,CGPA,s_branch,S_dob)
 PlacementDrive( Drive_id,Pcompany_name,package,location)
 Training ( T_id,Tcompany_name,T_Fee,T_year) 
Note: Use referential integrity constraints while creating tables with on delete cascade options. 
 Create view(simple), index, sequence and synonym based on above tables.  
*/

CREATE TABLE placement_drive(
    id int auto_increment primary key,
    company_name varchar(50),
    package int,
    location varchar(50),
);

CREATE TABLE training(
    id int auto_increment primary key,
    company_name varchar(50),
    fee int,
    training_year year
);

CREATE TABLE students(
    id int auto_increment primary key,
    drive_id int,
    training_id int,
    name_ varchar(50),
    cgpa float,
    branch varchar(50),
    foreign key(drive_id) references placement_drive(id) on delete cascade,
    foreign key(training_id) references training(id) on delete cascade
);