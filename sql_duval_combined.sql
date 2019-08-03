-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/i6siTq
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(10)   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(30)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "gender" CHAR(1)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" MONEY   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "dept_manager" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_to_date" FOREIGN KEY("to_date")
REFERENCES "salaries" ("to_date");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_from_date" FOREIGN KEY("from_date")
REFERENCES "titles" ("from_date");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- CHECK ALL DATA IMPORTED

SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

-- TASK #1
-- List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;

-- TASK #2
-- List employees who were hired in 1986.

SELECT * FROM employees;

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1987-01-01';

-- TASK #3
-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

SELECT * FROM dept_manager;
SELECT * FROM departments;
SELECT * FROM employees;

SELECT employees.first_name, employees.last_name, dept_manager.from_date, dept_manager.to_date, dept_manager.emp_no, departments.dept_name, departments.dept_no
FROM employees
INNER JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
INNER JOIN departments
ON dept_manager.dept_no = departments.dept_no;

-- TASK #4
-- List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT * FROM dept_emp;
SELECT * FROM departments;
SELECT * FROM employees;

SELECT employees.first_name, employees.last_name, dept_emp.emp_no, departments.dept_name
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
ON dept_emp.dept_no = departments.dept_no;

-- TASK #5
-- List all employees whose first name is "Hercules" and last names begin with "B."

SELECT employees.first_name, employees.last_name
FROM employees
WHERE
	first_name = 'Hercules'
	AND last_name LIKE 'B%';

-- TASK #6
-- List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT * FROM departments;

SELECT employees.first_name, employees.last_name, dept_emp.emp_no, departments.dept_name
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE
	dept_name = 'Sales';
	
-- TASK #7
-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
	
SELECT employees.first_name, employees.last_name, dept_emp.emp_no, departments.dept_name
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE
	dept_name = 'Sales' 
	OR dept_name = 'Development';
	
-- TASK #8
-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT first_name, COUNT(first_name) AS "actor count"
FROM actor
GROUP BY first_name
ORDER BY "actor count" DESC;
