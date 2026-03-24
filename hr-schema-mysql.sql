-- JOINS :- always keys (primary key, forein

use hr;
SELECT * FROM countries;

-- INNER JOINS:-

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;

-- Name of manager and the departments

SELECT * FROM employees AS e
JOIN Departments AS d ON d.manager_id = e.employee_id;


SELECT e.employee_id, 
e.first_name, 
e.last_name, 
e.manager_id, 
d.manager_id, 
d.department_name
FROM employees AS e
JOIN Departments AS d ON d.manager_id = e.employee_id;

-- joins.spathon.com

-- SELF LOINS :- 

SELECT * FROM employees;

-- find the number of employees under each manager


SELECT manager_id, COUNT(employee_id) FROM employees
GROUP BY manager_id;

SELECT 
      CONCAT(e1.first_name, " ", e1.last_name) AS emp_name,
      CONCAT(e2.first_name, " ", e2.last_name) AS mng_name
FROM employees AS e1
JOIN employees AS e2 
	ON e1.manager_id = e2.employee_id;
    

SELECT 
  CONCAT(e2.first_name, " ", e2.last_name) AS mng_name,
  COUNT(e1.employee_id) AS emp_count
FROM employees AS e1
JOIN employees AS e2 
  ON e1.manager_id = e2.employee_id
GROUP BY CONCAT(e2.first_name, " ", e2.last_name);

-- LEFT JOIN, RIGHT JOIN, INNER JOIN

SELECT 
	CONCAT(e1.first_name, " ", e1.last_name) AS emp_name,
	CONCAT(e2.first_name, " ", e2.last_name) AS mng_name
FROM employees AS e1
LEFT JOIN employees AS e2 
	ON e1.manager_id = e2.employee_id;
    
SELECT 
  CONCAT(e2.first_name, " ", e2.last_name) AS mng_name,
  COUNT(e1.employee_id) AS emp_count
FROM employees AS e1
LEFT JOIN employees AS e2 
  ON e1.manager_id = e2.employee_id
GROUP BY CONCAT(e2.first_name, " ", e2.last_name);
    
SELECT 
	CONCAT(e1.first_name, " ", e1.last_name) AS emp_name,
	CONCAT(e2.first_name, " ", e2.last_name) AS mng_name
FROM employees AS e1
RIGHT JOIN employees AS e2 
	ON e1.manager_id = e2.employee_id;
    
    
    SELECT 
  CONCAT(e2.first_name, " ", e2.last_name) AS mng_name,
  COUNT(e1.employee_id) AS emp_count
FROM employees AS e1
RIGHT JOIN employees AS e2 
  ON e1.manager_id = e2.employee_id
GROUP BY CONCAT(e2.first_name, " ", e2.last_name);


SELECT 
	CONCAT(e1.first_name, " ", e1.last_name) AS emp_name,
	CONCAT(e2.first_name, " ", e2.last_name) AS mng_name
FROM employees AS e1
INNER JOIN employees AS e2 
	ON e1.manager_id = e2.employee_id;
    

SELECT 
  CONCAT(e2.first_name, " ", e2.last_name) AS mng_name,
  COUNT(e1.employee_id) AS emp_count
FROM employees AS e1
INNER JOIN employees AS e2 
  ON e1.manager_id = e2.employee_id
GROUP BY CONCAT(e2.first_name, " ", e2.last_name);    

-- FIND HOW MANY EMPOLYEES ARE THERE IN EACH DEPARTMENT

SELECT * 
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
JOIN locations AS l ON d.location_id = l.location_id;

    
SELECT 
    CONCAT(l.city, " ", l.state_province, " ", l.country_id) AS loc,
    d.department_name AS Dept, 
    CONCAT(e.first_name, " ", e.last_name) AS employee_name
FROM departments AS d
JOIN employees AS e ON d.department_id = e.department_id
JOIN locations AS l ON d.location_id = l.location_id;

-- CROSS JOIN:-

SELECT * 
FROM employees
CROSS JOIN departments;



-- SUBQUERRIES:- Querry insides the querry

-- what is percentage expanse per employee

SELECT SUM(salary) FROM employees;

SELECT first_name,
  last_name, 
  salary,
  (salary/(SELECT SUM(salary) FROM employees)) AS perc,
  (SELECT SUM(salary) FROM employees) AS total
FROM employees;

SELECT * FROM
(SELECT first_name,
   last_name,
   salary,
   department_id
FROM employees ) AS t;

SELECT CONCAT(first_name, " ", last_name), salary,
    ROUND(salary/ (SELECT SUM(salary) FROM employees ) * 100, 2) AS pct
FROM
(SELECT first_name,
   last_name,
   salary,
   department_id
FROM employees ) AS t;

-- list all employees having salary more than the employee_id 103

SELECT first_name,
   last_name,
   salary
FROM employees
WHERE salary > (
    SELECT salary
    FROM employees
    WHERE employee_id = 103
);

-- display all employees who werw hired after 125

SELECT hire_date FROM employees WHERE employee_id = 125 ;

SELECT first_name,
   last_name,
   hire_date 
FROM employees 
WHERE hire_date > (SELECT hire_date FROM employees WHERE employee_id = 125);

-- find all the employees who earns more than avg salary

SELECT AVG(salary) FROM employees;

SELECT first_name,
   last_name,
   salary
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT COUNT(employee_id)
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees) ;

-- find all employees whose salary is less than the minimum salary of department 90

SELECT min(salary) FROM employees WHERE department_id = 90;

SELECT COUNT(employee_id)
FROM employees
WHERE salary < (SELECT min(salary) FROM employees WHERE department_id = 90);

SELECT *
FROM employees
WHERE salary < (SELECT min(salary) FROM employees WHERE department_id = 90);

-- find the employees with lowest salary

SELECT * FROM employees
ORDER BY salary ASC LIMIT 1;

SELECT * FROM employees 
WHERE salary = (SELECT min(salary) FROM employees);

SELECT first_name, last_name,
salary
FROM employees 
WHERE salary = (SELECT min(salary) FROM employees);

-- not exact ans

SELECT CONCAT(first_name, " ", last_name) AS fullname,
min(salary) AS lowest_salary
FROM employees
GROUP BY CONCAT(first_name, " ", last_name) ;

SELECT first_name,
min(salary) AS lowest_salary
FROM employees
GROUP BY first_name;

SELECT first_name, last_name,
min(salary) AS lowest_salary
FROM employees
GROUP BY first_name, last_name;




-- VIEWS:- IT IS VIRTUAL TABLE

CREATE VIEW emp_dept AS
SELECT e.employee_id,
concat(e.first_name, " ", e.last_name),
e.salary,
d.department_id,
d.department_name
FROM employees AS e
JOIN departments AS d ON e.department_id = d.department_id;

SELECT * FROM emp_dept;

CREATE VIEW us_employees AS
SELECT e.employee_id, e.first_name, e.last_name,
      d.department_id,d.department_name,
      l.state_province
FROM employees AS e
JOIN departments AS d ON e.department_id = d.department_id
JOIN locations as l ON l.location_id = d. location_id
WHERE country_id = "US";

SELECT * FROM us_employees;












