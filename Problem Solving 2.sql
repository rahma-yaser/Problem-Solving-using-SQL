-- 1.    Display the employees last names and commissions for all employees, if no commission, displays (no commission). Hint : use to_char function

select last_name, nvl(to_char(commission_pct), 'no commission') as commissions
from employees;

-- 2.    Write a Query that get the date of the First Sun day in the next month Print it in format   like 14-december-2020

select to_char(next_day(last_day(sysdate), 'Sunday'), 'FMdd-month-yyyy')
from dual;

-- 3.    Write a Query that get the last day date after 3 months from today Print it in format   like 14-december-2020

select to_char(last_day(add_months(sysdate, 3)), 'FMdd-month-yyyy')
from dual;

-- 4.    Display the employee’s name, hire date and salary review date,  The salary review date is the first Monday after six months of service. Label the column Review. Format the dates to appear in the format similar to “Sunday, the Seventh of September, 1981 “.

select first_name || ' ' || last_name as employee_name, hire_date, to_char(next_day(add_months(hire_date, 6), 'Monday'), 'FMDay, "the" ddspth "of" Month"," yyyy')
from employees;

-- 5.    Write a query that will display the difference between the highest and lowest salaries in each department.

select department_id, department_name, 
(select nvl(max(salary) - min(salary) , 0)
from employees 
where employees.department_id = out_qry.department_id)
as diff_bet_sal
from departments out_qry;

-- OR

select departments.department_id, max(salary) - min(salary) as avg_sal
from departments, employees
where departments.department_id = employees.department_id
group by departments.department_id
order by departments.department_id asc;


-- 6.    write a query that will display the city, department name number of employees and the average salary for all employee in that department, round the average salary to two decimal places. 

select city, department_name, (select count(employee_id) from employees  where employees.department_id = departments.department_id) as num_of_emp_per_dept,
 (select nvl(round(avg(salary), 2),0) from employees where employees.department_id = departments.department_id ) as avg_salary
from departments join locations
on departments.location_id = locations.location_id
order by city;


-- 7.    Display the employee number, name and salary for all employee who earn more than the average salary.

select employee_id, last_name, salary
from employees
where salary > (select avg(salary) from employees);

-- 8.    Show Employees data Whose Salary is Higher Than Their Manager's and show Manager name, salary ( use sub query not join )  --->

select e.*, (select first_name ||  ' ' || last_name  from employees emp where emp.employee_id = e.manager_id) as manager_name, (select salary  from employees emp where emp.employee_id = e.manager_id) as manager_salary
from employees e
where salary > (select salary from employees where employees.employee_id = e.manager_id);

-- 9.    Show Employees data Who Earn the Lowest Salary in Their Department ( use subquery not join )

select  e.*
from employees e
where salary =  (select min(salary) from employees emp where emp.department_id = e.department_id)
order by e.department_id;

-- 10.    Find employees who have been hired earlier than anyone else in the same job ( use subquery not join )

select e.*
from employees e
where hire_date <= all  (select hire_date from employees emp where emp.job_id = e.job_id)
order by job_id;

-- 11.    Write a query to display employee_id, last_name, salary, dept id, dept name, job Id, job title, city, street address, country id, country name, region id, region name for all employees including those employees whose have no department too.

select e.employee_id, last_name, salary, d.department_id, department_name, j.job_id, job_title, city, street_address, c.country_id, country_name, r.region_id, region_name
from employees e 
left join departments d on e.department_id = d.department_id
left join jobs j on e.job_id = j.job_id
left join locations l on d.location_id = l.location_id
left join countries c on l.country_id = c.country_id
left join regions r on c.REGION_ID = r.region_id
order by d.department_id;

