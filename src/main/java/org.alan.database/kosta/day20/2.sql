select empno, ename, job, sal
from emp
where sal > '1500'
and comm is null
and job = 'MANAGER'
or deptno > 0
order by sal desc
-- with "" capital small distinguish

select * from user_tables;

select upper('oracle') as "Capital", 
ename, 
initcap(ename) as "Capital only for beginning",
job
from emp
where job = upper('Manager');
-- where lower(job) = lower('manager') DO NOT HANDLE COLUMN NAME !!

create table test3(id number, name varchar2(9));

insert into test3 values(1, '선영');
insert into test3 values(1, '허선영');
--insert into test3 values(1, '허선영이');
insert into test3 values(1, 'Sun Young');
--insert into test3 values(1, 'Sun Young Heo');

select * from test3;

select ename, job, substr(ename, 2, 3) as "from 2, print 3 characters"
from EMP
where substr(job, 6, 3) = 'MAN';

select *
from jobs
where substr(job_title, -7 , 7) = initcap('manager');
-- -7 from behind count, initcap : for ignorant users

select *
from jobs
where job_title like '%' || initcap('manageR');
--?????

select *
from emp;

select first_name, hire_date, 
substr(hire_date, 1, 2) as "Year",
substr(hire_date, 4, 2) as "Month",
substr(hire_date, 7, 2) as "Day"
from employees;

select ename, sal * 12 + nvl(comm, 0)
from emp

select empno, ename, sal
from emp
where sal <= 1500;

select empno, ename, sal
from emp
where ename = 'SCOTT';
