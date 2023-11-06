INSERT INTO placement_drive(company_name,package,location)
VALUES
('barclays',35,'pune'),
('mastercard',14,'mumbai'),
('arista',28,'bengaluru'),
('deustche_bank',19,'pune'),
('bny_mellon',20,'bengaluru');

INSERT INTO training(company_name,fee,training_year)
VALUES
('barclays',5000,2024),
('mastercard',3000,2020),
('arista',1000,2021),
('deustche_bank',500,2019),
('bny_mellon',50,'2025');

INSERT INTO students(drive_id,training_id,name_,cgpa,branch)
VALUES
( 1 , 2 , 'Krishna Patil' , 8.7 , 'CE' ),
( 1 , 3 , 'Shantanu Wable' , 6.2 , 'CE' ),
( 3 , 2 , 'Ameya Surana' , 9.0 , 'CE' ),
( 2 , 2 , 'Tejas Thorat' , 8.1 , 'CE' ),
( 1 , 4 , 'Manthan Adhav' , 8.1 , 'IT' ),
( 4 , 1 , 'Advait Nagarkar' , 8.0 , 'IT' ),
( 3 , 3 , 'Rana Vanikar' , 6.8 , 'ENTC' ),
( 2 , 5 , 'Suma Meghana' , 7.8 , 'ENTC' );