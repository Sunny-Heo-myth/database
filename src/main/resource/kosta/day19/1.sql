-- select statement practice

select * from tab;

select * from EMPLOYEES;

select * from DEPARTMENTS;

select FIRST_NAME, SALARY 급여, SALARY*12 as 연봉,
COMMISSION_PCT, NVL(COMMISSION_PCT, 0) * 100 as "null 연산"
FROM EMPLOYEES;
where FIRST_NAME = 'Steven';
-- select : coloum
-- from table
-- "" is identifier(Capital distinguish), '' is value.

select EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME || '의 급여는 ' || SALARY || ' 입니다.' as "full name"
from employees

--|| concatenate

select distinct department_id
from employees

select empno, ename, sal
from emp
where ename ='FORD';
-- interpretation order : from where select

select empno, ename, sal
from emp
where sal <= 1500
order by 3;
-- interpretation order : from where select orderby

select *
from emp
where HIREDATE >= '1982/01/01';

select *
from emp
where sal between 2000 and 3000;

select *
from tab;

select *
from dept;

select sal + comm
from emp;