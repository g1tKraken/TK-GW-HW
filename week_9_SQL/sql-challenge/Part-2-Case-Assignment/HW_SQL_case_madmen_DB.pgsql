
-- List the following details of each employee:
-- employee number, last name, first name, sex, and salary.

-- 300024 rows returned
SELECT e.emp_no, e.last_name, e.first_name, e.sex, cast(s.salary as money)
FROM employees e, saleries s
WHERE e.emp_no = s.emp_no
--LIMIT 50;

-- SELECT count(*) FROM saleries
-- List first name, last name, and hire date for employees who were hired in 1986.

-- 36150 rows returned
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(year FROM "hire_date") = 1986
--LIMIT 50;

-- List the manager of each department with the following information:
-- department number, department name, the manager's employee number, last name, first name.

-- 24 rows returned
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM employees e, departments d, dept_manager m, staff_type s
WHERE e.emp_no = m.emp_no
    AND d.dept_no = m.dept_no
    AND s.title_id = e.emp_title_id
    AND s.title = 'Manager'
    AND e.emp_no in (
        SELECT emp_no
        FROM dept_manager)
ORDER BY d.dept_no


-- List the department of each employee with the following information:
-- employee number, last name, first name, and department name.

-- 331603 rows returned
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name 
FROM employees e, departments d, emp_dept m
WHERE e.emp_no = m.emp_no
    AND d.dept_no = m.dept_no
ORDER BY e.emp_no
--LIMIT 50;

-- List first name, last name, and sex
-- for employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

-- List all employees in the Sales department,
-- including their employee number, last name, first name, and department name.

-- 52245 rows returned
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name 
FROM employees e, departments d, emp_dept m
WHERE e.emp_no = m.emp_no
    AND d.dept_no = m.dept_no
    AND d.dept_name = 'Sales'
ORDER BY e.emp_no
--LIMIT 50;

-- List all employees in the Sales and Development departments,
-- including their employee number, last name, first name, and department name.

-- 137952 rows returned
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name 
FROM employees e, departments d, emp_dept m
WHERE e.emp_no = m.emp_no
    AND d.dept_no = m.dept_no
    AND (d.dept_name = 'Sales' OR d.dept_name = 'Development')
ORDER BY e.emp_no

SELECT * FROM departments
-- In descending order, list the frequency count of employee last names, i.e.,
-- how many employees share each last name.

-- 1638 rows returned
SELECT count(last_name), last_name
FROM employees
GROUP BY last_name
ORDER BY last_name DESC


-- extra

--	499942	April	Foolsday	F	$40,000.00
SELECT e.emp_no, e.first_name, e.last_name, e.sex, cast(s.salary as money)
FROM employees e, saleries s
WHERE e.emp_no = s.emp_no AND e.emp_no = 499942
