
CREATE INDEX index_students_name
on students(name_);


CREATE INDEX index_training_company_name
on training(company_name,training_year);


CREATE Unique INDEX index_placement_drive_package
on placement_drive(package);


CREATE VIEW comp_students
AS SELECT * FROM students WHERE branch = 'CE';

CREATE VIEW pune_placement_drive
AS SELECT * FROM placement_drive WHERE location = 'pune';


SELECT * FROM comp_students;

SELECT * FROM pune_placement_drive;