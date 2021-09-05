select ename
from emp
where hiredate <= '1982/01/01';

select *
from EMP
where deptno = 10 and job = 'MANAGER';

select empno, sal
from emp
where empno = 7521 or empno = 7654 or empno = 7844;

select empno, sal * 12 + comm
from emp
where comm in(300, 500, 1400);

select empno, sal
from EMP
where empno in(7521, 7654, 7844);

select empno, sal * 12 + comm
from emp
where comm not in(300, 500, 1400);

select empno, sal * 12 + comm, comm
from emp
where comm not between 500 and 900;

select empno, ename
from EMP
where empno not in(7521, 7654, 7844);

select empno, ename
from EMP
where not empno = 7521 and not empno = 7654 and not empno = 7844;

select *
from emp
where ename like 'F%';

select *
from EMP
where ename like 'J%';  -- start with

select *
from EMP
where ename like '%A%'; -- existence

select *
from emp
where ename like '%N';  -- end with

select empno, ename
from emp
where ename like 'K%';

select empno, ename
from emp
where ename like '%K%';

select empno, ename
from emp
where ename like '%K'

select *
from EMP
where ename like '_A%'

select *
from EMP
where ename like '%A'

select *
from EMP
where ename like '____%K'

select *		
from EMP
where ename not like '%A%'; --not existence

select *
from emp
where comm is null;

select *
from EMP
where comm is not null;

select *
from emp
where mgr is null;

select empno, job, hiredate
from EMP
order by hiredate desc;

select empno, ename
from emp
order by empno;

select *
from emp
order by ename;

select *
from emp
order by hiredate desc;

select *
from emp
order by sal desc, ename;

select empno, hiredate, ename, sal, deptno
from emp
order by deptno, hiredate desc;

desc dual;
-- ??

select *
from dual;

select -10, abs(-10)
from dual;

select 34.5678, floor(34.5678)
from dual;

select 34.5678, round(34.5678, 2)
from dual;

select 34.5678, round(34.5678, -1)
from dual;

select 34.5678, trunc(34.5678, -1)
from dual;

select 34.5678, trunc(34.5678, 2)
from dual;

select mod(325, 42), mod(325, 41), mod(325, 34)
from dual;

select *
from emp
where mod(empno, 2) = 1;

select substr(ename, 3)
from emp;

select 'welcome to oracle', upper('welcome to oracle')
from dual;

select 'welcome to oracle', initcap('welcome to oracle')
from dual;

select empno, ename, job
from emp
where job = 'manager';

select empno, ename, job
from emp
where job = upper('manager');  -- difference

select empno, ename, job
from emp
where lower(job) = 'manager';

select * from tab;

select length('Oracle'), length('오라클')
from dual;

select lengthb('Oracle'), lengthb('오라클')
from dual;

select substr('Welcome to Oracle', -6, 6)
from dual;

select substr(hiredate, 1, 2) as year, substr(hiredate, 4, 2) as month
from emp;

select *
from emp
where substr(hiredate, 4, 2) = '09';

select *
from emp
where substr(hiredate, 1, 2) = '81';

select ename
from emp
where substr(ename, -1, 1) = 'E'

select substr('Welcome to Oracle', 3, 4), 
		substrb('Welcome to Oracle', 3, 4)
from dual;

select substr('웰컴투오라클', 3, 4), 
		substrb('웰컴투오라클', 3, 4)
from dual;

select instr('welcome to oracle', 'o')
from dual;

select instr('welcome to oracle', 'o', 2)
from dual;

select instr('welcome to oracle', 'o', 1, 1)
from dual;

select instr('welcome to oracle', 'o', 5, 2)
from dual;

select instr('welcome to oracle', 'o', 6, 2)
from dual;

select instrb('database is consistent.', 'a', 2)
from dual;

select instrb('데이터베이스는 무결하다.', '이', 1, 1)
from dual;

select instrb('데이터베이스는 무결하다.', '이', 5, 1)
from dual;

select ename
from emp
where ename like '__R%';

select ename
from emp
where instr(ename, 'R', 1, 1) = 3;

select lpad()