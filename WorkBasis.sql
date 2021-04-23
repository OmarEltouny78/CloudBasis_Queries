MySQL [employees]> SELECT COUNT(DISTINCT emp_no) FROM dept_emp WHERE from_date='1985-01-01' AND to_date>'1990-01-01';
+------------------------+
| COUNT(DISTINCT emp_no) |
+------------------------+
|                      9 |
+------------------------+
1 row in set (0.963 sec)

MySQL [employees]> SELECT COUNT(DISTINCT emp_no) FROM dept_emp WHERE from_date BETWEEN '1985-01-01' AND '1990-01-01'  AND to_date>'1990-01-01';
+------------------------+
| COUNT(DISTINCT emp_no) |
+------------------------+
|                  95293 |
+------------------------+
1 row in set (1.669 sec)

MySQL [employees]> SELECT COUNT(DISTINCT emp_no) FROM dept_emp WHERE from_date BETWEEN '1985-01-01' AND '1995-01-01'  AND to_date>'1995-01-01';
+------------------------+
| COUNT(DISTINCT emp_no) |
+------------------------+
|                 183485 |
+------------------------+
1 row in set (2.069 sec)

MySQL [employees]> SELECT COUNT(DISTINCT emp_no) FROM dept_emp WHERE from_date BETWEEN '1985-01-01' AND '2000-01-01'  AND to_date>'2000-01-01';
+------------------------+
| COUNT(DISTINCT emp_no) |
+------------------------+
|                 257293 |
+------------------------+
1 row in set (2.212 sec)

MySQL [employees]> SELECT AVG(salary) FROM salaries WHERE from_date BETWEEN '1985-01-01' AND '1990-01-01'  AND to_date>'1990-01-01';
+-------------+
| AVG(salary) |
+-------------+
|  56844.1205 |
+-------------+
1 row in set (9.527 sec)

MySQL [employees]> SELECT AVG(salary) FROM salaries WHERE from_date BETWEEN '1985-01-01' AND '1995-01-01'  AND to_date>'1995-01-01';
+-------------+
| AVG(salary) |
+-------------+
|  61744.0226 |
+-------------+
1 row in set (10.358 sec)

MySQL [employees]> SELECT AVG(salary) FROM salaries WHERE from_date BETWEEN '1985-01-01' AND '2000-01-01'  AND to_date>'2000-01-01';
+-------------+
| AVG(salary) |
+-------------+
|  66593.2145 |
+-------------+
1 row in set (10.370 sec)

MySQL [employees]> SELECT COUNT(DISTINCT title) FROM titles WHERE from_date BETWEEN '1985-01-01' AND '1990-01-01'  AND to_date>'1990-01-01';
ERROR 2006 (HY000): MySQL server has gone away

+-----------------------+
| COUNT(DISTINCT title) |
+-----------------------+
|                     7 |
+-----------------------+
1 row in set (3.928 sec)

MySQL [employees]> SELECT DISTINCT title FROM titles WHERE from_date BETWEEN '1985-01-01' AND '1990-01-01'  AND to_date>'1990-01-01';
+--------------------+
| title              |
+--------------------+
| Senior Engineer    |
| Engineer           |
| Staff              |
| Assistant Engineer |
| Senior Staff       |
| Technique Leader   |
| Manager            |
+--------------------+
7 rows in set (2.242 sec)

MySQL [employees]> SELECT DISTINCT title,COUNT(emp_no) FROM titles WHERE from_date BETWEEN '1985-01-01' AND '1990-01-01'  AND to_date>'1990-01-01' GROUP BY title;
+--------------------+---------------+
| title              | COUNT(emp_no) |
+--------------------+---------------+
| Assistant Engineer |          4782 |
| Engineer           |         33474 |
| Manager            |             9 |
| Senior Engineer    |          9683 |
| Senior Staff       |          8412 |
| Staff              |         34165 |
| Technique Leader   |          4768 |
+--------------------+---------------+
7 rows in set (2.761 sec)

MySQL [employees]> SELECT DISTINCT titles.title,AVG(salaries.salary) FROM titles INNER JOIN salaries ON titles.emp_no=salaries.emp_no WHERE from_date BETWEEN '1985-01-01' AND '1990-01-01'  AND to_date>'1990-01-01' GROUP BY title;
ERROR 1052 (23000): Column 'from_date' in where clause is ambiguous
MySQL [employees]> SELECT DISTINCT titles.title,AVG(salaries.salary) FROM titles INNER JOIN salaries ON titles.emp_no=salaries.emp_no WHERE salaries.from_date BETWEEN '1985-01-01' AND '1990-01-01'  AND salaries.to_date>'1990-01-01' GROUP BY title;
+--------------------+----------------------+
| title              | AVG(salaries.salary) |
+--------------------+----------------------+
| Assistant Engineer |           52340.6964 |
| Engineer           |           52462.0253 |
| Manager            |           58861.0909 |
| Senior Engineer    |           52518.0909 |
| Senior Staff       |           62401.1642 |
| Staff              |           62313.6480 |
| Technique Leader   |           52334.0704 |
+--------------------+----------------------+
7 rows in set (14.609 sec)

MySQL [employees]> SELECT COUNT(DISTINCT emp_no),dept_no FROM dept_emp WHERE from_date BETWEEN '1985-01-01' AND '1990-01-01'  AND to_date>'1990-01-01';
ERROR 1140 (42000): In aggregated query without GROUP BY, expression #2 of SELECT list contains nonaggregated column 'employees.dept_emp.dept_no'; this is incompatible with sql_mode=only_full_group_by
MySQL [employees]> SELECT COUNT(DISTINCT emp_no),dept_no FROM dept_emp WHERE from_date BETWEEN '1985-01-01' AND '1990-01-01'  AND to_date>'1990-01-01' GROUP BY dept_no;
+------------------------+---------+
| COUNT(DISTINCT emp_no) | dept_no |
+------------------------+---------+
|                   5266 | d001    |
|                   5277 | d002    |
|                   5308 | d003    |
|                  21176 | d004    |
|                  25971 | d005    |
|                   5390 | d006    |
|                  15797 | d007    |
|                   5468 | d008    |
|                   5640 | d009    |
+------------------------+---------+
9 rows in set (5.973 sec)

MySQL [employees]> SELECT DISTINCT dept_emp.dept_no,AVG(salaries.salary) FROM dept_emp INNER JOIN salaries ON dept_emp.emp_no=salaries.emp_no WHERE salaries.from_date BETWEEN '1985-01-01' AND '1990-01-01'  AND salaries.to_date>'1990-01-01' GROUP BY dept_emp.dept_no;
+---------+----------------------+
| dept_no | AVG(salaries.salary) |
+---------+----------------------+
| d001    |           65044.2673 |
| d002    |           63661.9575 |
| d003    |           48617.3643 |
| d004    |           52707.4285 |
| d005    |           52552.1159 |
| d006    |           50257.4028 |
| d007    |           73706.4632 |
| d008    |           52706.9122 |
| d009    |           51648.2055 |
+---------+----------------------+
9 rows in set (13.669 sec)

MySQL [employees]> SELECT MAX(salary) FROM salaries WHERE from_date BETWEEN '1985-01-01' AND '1990-01-01'  AND to_date>'1990-01-01';
+-------------+
| MAX(salary) |
+-------------+
|      132196 |
+-------------+
1 row in set (8.520 sec)

MySQL [employees]> SELECT emp_no FROM salaries WHERE from_date BETWEEN '1985-01-01' AND '1990-01-01'  AND to_date>'1990-01-01' AND salary=132196;
+--------+
| emp_no |
+--------+
| 109334 |
+--------+
1 row in set (6.559 sec)

MySQL [employees]> SELECT title FROM titles WHERE from_date BETWEEN '1985-01-01' AND '1990-01-01'  AND to_date>'1990-01-01' AND emp_no=109334;
+-------+
| title |
+-------+
| Staff |
+-------+
1 row in set (0.250 sec)