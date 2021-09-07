select max(sal)
from emp;

desc table;

desc emp;

desc xe;

select *
from emp;

select *
from user_tables;

select *
from dept;

select deptno, max(sal), round(avg(sal))
from emp
group by deptno;

select count(comm)
from emp;

select count(*)
from emp;

select nvl(count(comm), 0)
from emp;

select count(comm)
from emp;

select comm
from emp;

select nvl(comm, 0)
from emp;

select deptno, job, nvl(count(comm), 0)
from emp
group by deptno, job
order by deptno, job;

select count(comm)
from emp;

select *
from emp;

select count(job) as What
from emp;

select count(distinct(job)) as What
from emp;

select deptno
from emp
group by deptno;

select deptno, avg(sal)
from emp
group by deptno;

select deptno, count(empno), count(comm)
from emp
group by deptno;

select deptno, avg(sal)
from emp
group by deptno
having avg(sal) >= 2000;

select deptno, max(sal), min(sal)
from emp
group by deptno
having max(sal) > 2900;

create table bit5(
name varchar2(20),
team varchar(10),
java_s number,
cpp_s number,
web_s number,
dep varchar2(20)
);

INSERT INTO BIT5 VALUES('천의령','1조',45,63,78,'비전공');
INSERT INTO BIT5 VALUES('김무준','1조',87,57,77,'비전공');
INSERT INTO BIT5 VALUES('방명광','1조',28,59,45,'컴공');
INSERT INTO BIT5 VALUES('조성규','1조',56,18,66,'비전공');
INSERT INTO BIT5 VALUES('서예슬','1조',28,64,81,'비전공');
INSERT INTO BIT5 VALUES('오정식','1조',NULL,23,09,'컴공');
INSERT INTO BIT5 VALUES('따거','2조',72,28,28,'컴공');
INSERT INTO BIT5 VALUES('김영민','2조',22,44,77,'컴공');
INSERT INTO BIT5 VALUES('','2조',77,77,56,'컴공');
INSERT INTO BIT5 VALUES('유호준','2조',65,45,91,'비전공');
INSERT INTO BIT5 VALUES('김기범','2조',78,63,31,'컴공');
INSERT INTO BIT5 VALUES('심준식','2조',54,30,81,'비전공');

desc bit5;

select team, dep, avg(java_s)
from bit5
group by dep, team
order by dep, team;

select *
from dept;

select *
from emp;

select *
from emp, dept;

select *
from emp, dept
where emp.deptno = dept.deptno

select ename, dname
from emp, dept
where emp.ename = 'SMITH' and emp.deptno = dept.deptno;

select ename, dname, deptno
from emp, dept
where emp.deptno = dept.deptno and ename = 'SMITH'

select ename, dname, dept.deptno
from emp, dept
where emp.deptno = dept.deptno and ename = 'SMITH'

select e.ename, d.dname, e.deptno, d.deptno
from emp e, dept d
where e.deptno = d.deptno and e.ename = 'SMITH';

select e.ename, e.sal
from emp e, dept d
where e.deptno = d.deptno and d.loc = 'NEW YORK'

select *
from emp e, dept d
where d.loc = 'NEW YORK'

select *
from emp e, dept d
where e.ename = 'SMITH'

select e.ename, e.hiredate
from emp e, dept d
where e.deptno = d.deptno and d.dname = 'ACCOUNTING'

select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno and e.job = 'MANAGER'

select * from salgrade;

select ename, sal, grade
from emp, salgrade
where sal between losal and hisal

select ename, mgr
from emp

select a.ename, a.job
from emp a, emp b
where a.mgr = b.empno
and b.ename = 'KING'

select *
from emp

select *
from dept

select a.ename, c.loc, a.deptno
from emp a, emp b, dept c, dept d
where a.deptno = c.deptno
and b.deptno = d.deptno
and c.loc = d.loc
and b.ename = 'SMITH'

select e1.ename
from emp e1, emp e2, dept d1, dept d2
where e1.deptno = d1.deptno
and e2.deptno = d2.deptno
and d1.loc = d2.loc
and e2.ename = 'MILLER'

select e.ename || '''s manager is ' || m.ename || '.'
from emp e, emp m
where e.mgr = m.empno

select e.ename || 's manager is ' || m.ename || '.'
from emp e, emp m
where e.mgr = m.empno(+)

select * from dept

select e.ename, d.deptno, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno

select e.ename, d.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno(+)

select *
from emp cross join dept;

select ename, dname
from emp inner join dept
on emp.deptno = dept.deptno
where ename = 'SMITH'

select ename, dname
from emp join dept
using (deptno)

select ename, dname
from emp natural join dept;

select e.ename || 's manager is ' || m.ename || '.'
from emp e, emp m
where e.mgr = m.empno(+)

select e.ename || 's manager is ' || m.ename || '.'
from emp e right outer join emp m
where e.mgr = m.empno

create table dept01(
deptno number(2),
dname varchar2(14)
)

insert into dept01 values(10, 'ACCOUNTING')
insert into dept01 values(20, 'RESEARCH')

create table dept02(
deptno number(2),
dname varchar2(14)
)

insert into dept02 values(10, 'ACCOUNTING')
insert into dept02 values(30, 'SALES')

select *
from dept02

delete
from dept02
where deptno = 20;

select *
from dept01 cross join dept02

select *
from dept01 left outer join dept02
on dept01.deptno = dept02.deptno

select *
from dept01 right outer join dept02
on dept01.deptno = dept02.deptno

select *
from dept01 full outer join dept02
on dept01.deptno = dept02.deptno

drop table dept01;
drop table dept02;

create table dept01(
deptno number(2),
dname varchar2(14));

insert into dept01 values(10, 'ACCOUNTING');
insert into dept01 values(20, 'RESEARCH');

create table dept02(
deptno number(2),
dname varchar(14));

insert into dept02 values(10, 'ACCOUNTING');
insert into dept02 values(30, 'SALES');

select *
from dept01;

select *
from dept01 left outer join dept02
on dept01.deptno = dept02.deptno;

select *
from dept01 right outer join dept02
on dept01.deptno = dept02.deptno;

select *
from dept01 right outer join dept02
using(deptno);

select *
from dept01 full outer join dept02
using(deptno)

select *
from dept01 natural full outer join dept02

select dname
from dept
where deptno = (select deptno
from emp
where ename = 'SMITH'
);

select ename, deptno
from emp
where deptno = (select deptno
from emp
where ename = 'SMITH');

select e1.ename, e1.deptno
from emp e1 join emp e2
on e1.deptno = e2.deptno
where e2.ename = 'SMITH';

select ename, sal
from emp
where sal >= (select sal
from emp
where ename = 'SMITH');

select ename, sal
from emp
where sal >= (select sal
from emp
where ename = 'KING');

select *
from emp e join dept d
on e.deptno = d.deptno;

select e.ename, e.deptno
from emp e join dept d
on e.deptno = d.deptno
where d.loc = (select loc
from dept
where loc = 'DALLAS');

select e.ename, e.deptno
from emp e join dept d
on e.deptno = d.deptno
where d.loc = 'DALLAS';

select e.ename, e.sal, nvl(e.comm, 0)
from emp e join dept d
on e.deptno = d.deptno
where d.dname = 'SALES';

select ename, sal
from emp e
where e.mgr = (select empno
from emp
where ename = 'KING');

select ename, sal
from emp
where sal > (select avg(sal)
from emp);

select *
from emp
where deptno = (
select distinct deptno
from emp
where sal >= 3000);

select ename, sal, deptno
from emp
where deptno in (
select distinct deptno
from emp
where sal >= 3000);

select max(sal)
from emp
where deptno = 20;

select *
from emp

select empno, ename, sal, deptno
from emp
where sal in (
select max(sal)
from emp
group by deptno
);

select *
from emp e join dept d
on e.deptno = d.deptno
where e.job in (
select job
from emp
where job = 'MANAGER');

select ename, sal
from emp
where sal > all(
select sal
from emp
where deptno = 30);

select max(e.sal)
from emp e join dept d
on e.deptno = d.deptno
where d.dname = 'SALES';

select *
from emp join dept
on emp.deptno = dept.deptno
where sal > all(
select e.sal
from emp e join dept d
on e.deptno = d.deptno
where d.dname = 'SALES');

select ename, sal
from emp
where sal > any(
select sal
from emp
where deptno = 30);

select *
from emp join dept
on emp.deptno = dept.deptno
where sal > any(
select e.sal
from emp e join dept d
on e.deptno = d.deptno
where d.dname = 'SALES');