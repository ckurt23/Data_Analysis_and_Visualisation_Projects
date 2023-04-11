-- Salaries Differences
-- LinkedIN   difficulty: easy

/*

Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments.
Output just the absolute difference in salaries.

Table: db_employee

id: int
first_name: varchar
last_name: varchar
salary: int
department_id: int

Table: db_dept

id: int
department: varchar

*/

SELECT
    ABS(
    MAX(CASE WHEN t1.department_id = 1 THEN salary ELSE 0 END) -
    MAX(CASE WHEN t1.department_id = 4 THEN salary ELSE 0 END)
    ) AS salary_difference
FROM 
    db_employee AS t1
