-- 1.    Display the first name and last name concatenated into a single column, separated by a space, and label the column as Full Name.
select FIRST_NAME || ' ' || last_name as full_name
from employees;

-- 2.    Retrieve the last name, department ID, and salary for employees whose department ID is either 50 or 60, and whose salary is greater than $5000.

select last_name, department_id, salary
from employees
where department_id in (50,60) and salary > 5000;

-- 3.    Find all employees whose job id contains the word 'Mgr' (case insensitive).

select *
from employees
where lower(job_id) like '%mgr%';

-- 4.    Show the last name and email address of employees whose email ends with 'oracle.com'. ( update data to check your answer )
select employee_id, last_name, email
from employees;

update employees
set email = last_name || '@oracle.com'
where employee_id between 100 and 110;

select employee_id, last_name, email
from employees
where email like '%oracle.com';

-- 5.    List the first name, job ID, and salary for employees whose salary is between $3000 and $6000 and whose job ID is not IT_PROG.

select first_name, job_id, salary
from employees
where salary between 3000 and 6000
and job_id <> 'IT_PROG';

-- 6.    Display the first and last name of employees who do not have any commission set

select first_name, last_name
from employees
where commission_pct is null;

-- 7.    Display the first character of the first name and the first character of the last name as initials, separated by a period (.), for all employees.

select first_name, last_name, substr(first_name, 1, 1) || '.' || substr(last_name, 1, 1) as intials
from employees;

-- 8.    Replace all dots (.) in phone numbers with hyphens ('-') in the phone_number column.

update employees
set phone_number = replace(phone_number, '.', '-');

select phone_number
from employees;

--9.    Extract the last word ( after _ ) from the job_title columns of each employee from table jobs

select employee_id, first_name || ' ' || last_name as full_name, employees.job_id, job_title, substr(job_title, instr(job_title, ' ')+1)
from employees inner join jobs
on employees.job_id = jobs.job_id; 

-- 10.    Display all employees whose emp id is odd.

select *
from employees
where mod(employee_id, 2) <> 0;

-- 11.    How many filled boxes will we need for 176 bottles – if box capacity = 6 And show if there are remaining bottles after filling those boxes

select trunc(176 / 6) as filled_boxes , mod(176, 6) as remaining_bottles
from dual;

-- 12.    Write a query that displays the grade of all employees based on the value of the column JOB ID, as per the table shown below using case, decode

--JOB_ID    GRADE
--AD_ASST    A
--IT_PROG    B
--SA_REP    C
--FI_MGR    D
--None of above    F

select job_id,
case
when job_id = 'AD_ASST'  then 'A'
when job_id = 'IT_PROG'  then 'B'
when job_id = 'SA_REP '  then 'C'
when job_id = 'FI_MGR' then 'D'
else 'F'
end
as employee_grade
from employees;

select job_id,
decode(job_id,  'AD_ASST',  'A', 'IT_PROG', 'B', 'SA_REP ', 'C',  'FI_MGR', 'D', 'F') as emp_grade
from employees;