-- create a visualization that provides a breakdown between the male and female employees working in the company each year, starting from 1990.
USE employees_mod;
SELECT 
     YEAR(d.from_date) AS calendar_year,
     e.gender, 
     COUNT(e.emp_no) AS num_emp
FROM t_employees e
JOIN t_dept_emp d
   USING(emp_no)
GROUP BY YEAR(d.from_date), e.gender
HAVING calendar_year >=1990
ORDER BY calendar_year;


-- compare the number of male managers to the number of female managers from different departments for each year, starting from 1990.
USE employees_mod;
SELECT 
     d.dept_name,
     ee.gender, 
     dm.emp_no,
     dm.from_date,
     dm.to_date,
     -- YEAR(ee.hire_date) AS calendar_year,
     e.calendar_year,
     CASE 
        WHEN e.calendar_year BETWEEN YEAR(dm.from_date) AND YEAR(dm.to_date) THEN 1
        ELSE 0
     END AS active
FROM (
      SELECT YEAR(hire_date) AS calendar_year
      FROM t_employees
      GROUP BY calendar_year
      ) e
CROSS JOIN t_dept_manager dm
-- FROM t_dept_manager dm
JOIN t_employees ee
   USING(emp_no)
JOIN t_departments d
   USING(dept_no)
-- GROUP BY YEAR(ee.hire_date)
ORDER BY dm.emp_no, calendar_year;



-- compare the average salary of female versus male employees in the entire company until year 2002, and add a filter allowing you to see that per each department.
USE employees_mod;
SELECT 
     d.dept_name,
     ee.gender, 
     YEAR(s.from_date) AS calendar_year,
     ROUND(AVG(s.salary),2) AS salary
FROM t_employees ee
JOIN t_salaries s
   USING(emp_no)
CROSS JOIN t_departments d
-- GROUP BY YEAR(ee.hire_date)
GROUP BY d.dept_name, ee.gender,calendar_year
HAVING calendar_year <= 2002
ORDER BY d.dept_name;
   

