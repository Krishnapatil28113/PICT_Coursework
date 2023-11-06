SELECT * FROM students
WHERE (branch = 'CE' || branch = 'IT') && (name_ like 'A%' || name_ like 'D%');

SELECT DISTINCT company_name FROM training;

DELETE FROM students
WHERE cgpa < 8.0;

SELECT s.name_
FROM students s
JOIN training t ON s.training_id = t.id;

SELECT t.id,t.fee,s.name_ FROM students s,training t
ORDER BY t.fee DESC;