-- 1. Create table with name of emp2 based on employees table ( with no data )- ( use insert with subquery ) to populate the emp2 table using a select statement from the employees table for the employees in department 60.

create table emp2 
as select * from employees
where 1 = 2;

insert into emp2
select * from employees where department_id = 60;

select * from emp2;


-- 2. Create the DEPARTMENT table based on the following table instance chart.    Create table command with 2 columns

-- COLUMN NAME     ID     NAME 
-- Default value    1    
-- DATATYPE    Number    Varchar2
-- LENGTH    7    25

create table department_table
(
ID number(7) default 1 ,
Name varchar2(25)
);

-- 2. a)    Populate the DEPARTMENT table with data from departments table. Include only columns that you need. ( insert using sub query )

insert into department_table
 select department_id, department_name from departments;
  
-- 2. b)    Add column 'Loc_name' to table department. ( varchar2 100 )

alter table department_table
add Loc_name varchar2(100);

-- 2. c)    Truncate table department.

truncate table department_table;


-- 3. Create table employee_bkp based on the structure of the employees table(Structure with data). 
-- Include only the employee_id, last_name, email, salary and department_id columns
--Change using alter
--Employee_id Primary key 
--email unique

create table employee_bkp
as select employee_id, last_name, email, salary,  department_id from employees;

alter table employee_bkp modify employee_id number(6) constraint empbkp_emp_id_pk primary key;

alter table employee_bkp modify email varchar2(25) constraint empbkp_email_uni unique;

-- 4. Create a view called EMP_VU based on the employee number, employee last name, and department number from the EMPlOYEES table. Change the heading for the last name to title_name

create view EMP_VU 
as
select employee_id, last_name as title_name, department_id
from employees;

-- 5. Create a sequence to be used with the primary key column of the DEPARTMENTS table. 
-- The sequence should start at 600 and have a maximum value of 1000. 
-- Have your sequence increment by ten numbers. Name the sequence DEPT_ID_SEQ. 
-- and use it to insert a new row in departments table

create sequence dept_id_seq
start with 600
increment by 10
maxvalue 1000;

select * from departments;

insert into departments
(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
values
(dept_id_seq.nextval, 'CS', 100, 1700);

-- 6.    Create the following tables using ddl
-- Trainers [ tr_id, tr_name, tr_mobile ]
-- Courses [ crs_id, crs_name, crs_price ]
-- Use Many to Many relationship; 
-- Solve using create tables, then alter trainers and add email column then alter again to add unique constraints;
-- Use insert to set those data 
-- Trainer [ aly ] > teach [ php – oracle – java ]
-- Trainer [ Mohamed ] > teach [ oracle ]
-- Trainer [ Omar ] > teach [ oracle – java ]
-- Then select the data using inner join

create sequence trainer_seq
start with 1
increment by 1;

create sequence course_seq
start with 1
increment by 1;

create table Trainers
(
tr_id number(2) constraint trainers_tr_id_pk primary key,
tr_name varchar2(25)
);

create table Trainers_phones
(
tr_id number(2),
tr_mobile number(11),
constraint trainers_phones_tr_id_fk foreign key(tr_id) references Trainers(tr_id),
constraint trid_trmobile_pk primary key(tr_id, tr_mobile)
);

create table Courses
(
crs_id number(2) constraint courses_cs_id_pk primary key, 
crs_name varchar2(25),
crs_price number(5)
);


create table Trainer_Course
(
tr_id number(2),
crs_id number(2),
constraint trainer_course_tr_id_fk foreign key (tr_id) references trainers(tr_id),
constraint trainer_course_crs_id_fk foreign key (crs_id) references courses(crs_id),
constraint trainer_course_tr_id_crs_id_pk primary key(tr_id, crs_id)
);

alter table trainers
add email varchar2(25);

alter table trainers
modify email varchar2(25) constraint trainers_email_uni unique;

insert into trainers
values
(trainer_seq.nextval, 'Aly','');
insert into trainers
values
(trainer_seq.nextval, 'Mohamed',null);
insert into trainers
values
(trainer_seq.nextval, 'Omar','omar@gmail.com');

insert
into courses
values
(course_seq.nextval, 'oracle',200);

insert
into courses
values
(course_seq.nextval, 'php',500);

insert
into courses
values
(course_seq.nextval, 'java',150);


insert all
into trainer_course
values (1, 2)
into trainer_course
values(1,3)
into trainer_course
values(1,4)
into trainer_course
values(2,2)
into trainer_course
values(3,2)
into trainer_course
values(3,4)
SELECT * FROM dual;

select tr_name , crs_name
from trainers inner join Trainer_Course
on trainers.tr_id = Trainer_Course.tr_id
inner join courses
on COURSES.CRS_ID = TRAINER_COURSE.CRS_ID;