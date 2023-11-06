

-- students
+----+----------+-------------+-----------------+------+--------+
| id | drive_id | training_id | name_           | cgpa | branch |
+----+----------+-------------+-----------------+------+--------+
|  1 |        1 |           2 | Krishna Patil   |  8.7 | CE     |
|  2 |        1 |           3 | Shantanu Wable  |  6.2 | CE     |
|  3 |        3 |           2 | Ameya Surana    |    9 | CE     |
|  4 |        2 |           2 | Tejas Thorat    |  8.1 | CE     |
|  5 |        1 |           4 | Manthan Adhav   |  8.1 | IT     |
|  6 |        4 |           1 | Advait Nagarkar |    8 | IT     |
|  7 |        3 |           3 | Rana Vanikar    |  6.8 | ENTC   |
|  8 |        2 |           5 | Suma Meghana    |  7.8 | ENTC   |
+----+----------+-------------+-----------------+------+--------+


-- training
+----+---------------+------+---------------+
| id | company_name  | fee  | training_year |
+----+---------------+------+---------------+
|  1 | barclays      | 5000 |          2024 |
|  2 | mastercard    | 3000 |          2020 |
|  3 | arista        | 1000 |          2021 |
|  4 | deustche_bank |  500 |          2019 |
|  5 | bny_mellon    |   50 |          2025 |
+----+---------------+------+---------------+


--placement_drive
+----+---------------+---------+-----------+
| id | company_name  | package | location  |
+----+---------------+---------+-----------+
|  1 | barclays      |      35 | pune      |
|  2 | mastercard    |      14 | mumbai    |
|  3 | arista        |      28 | bengaluru |
|  4 | deustche_bank |      19 | pune      |
|  5 | bny_mellon    |      20 | bengaluru |
+----+---------------+---------+-----------+