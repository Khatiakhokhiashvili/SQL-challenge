CREATE TABLE departments (
    dept_no CHAR(4) PRIMARY KEY,
    dept_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no CHAR(4) NOT NULL
);

CREATE TABLE titles (
    title_id VARCHAR PRIMARY KEY NOT NULL,
    title VARCHAR NOT NULL
);
CREATE TABLE employees(
    emp_no INT PRIMARY KEY NOT NULL,
    emp_title_id VARCHAR,
    birth_date VARCHAR,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    sex VARCHAR,
    hire_date VARCHAR,
  	FOREIGN KEY (emp_title_id) REFERENCES Titles(title_id)
);


CREATE TABLE dept_manager (
    emp_no INT NOT NULL,
    dept_no CHAR(4) NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    
    PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
__Data Analysis Question 1.
	
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

__Data Analysis Question 2.

SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM TO_DATE(hire_date, 'MM/DD/YYYY')) = 1986;

__Data Analysis Question 3.
	
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager as dm
Left JOIN departments  as d ON dm.dept_no = d.dept_no
LEft JOIN employees as e ON dm.emp_no = e.emp_no;

__Data Analysis Question 4.
	
SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp as de
JOIN employees as e ON de.emp_no = e.emp_no
JOIN departments as d ON de.dept_no = d.dept_no;

__Data Analysis Question 5.

SELECT e.first_name, e.last_name, e.sex
FROM employees as e
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';
	
__Data Analysis Question 6.
	
SELECT e.emp_no, e.last_name, e.first_name
FROM employees as e
JOIN dept_emp as de ON e.emp_no = de.emp_no
JOIN departments as d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

__Data Analysis Question 7.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees  as e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

__Data Analysis Question 8.


SELECT last_name, COUNT(*) AS frequency
FROM employees 
GROUP BY last_name
ORDER BY frequency DESC;