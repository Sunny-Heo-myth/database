select rowid, empno, ename
from emp;

create table sam02(
YEAR01 interval year(3) to month);

insert into sam02
values(interval '36' month(3));

select year01, sysdate, sysdate + year01
from sam02;

create table sam03(
day01 interval day(3) to second);

insert into sam03
values(interval '100' day(3));

select day01, sysdate, sysdate + day01
from sam03;

create table emp01(
empno number(4),
ename varchar2(20),
sal number(7, 2));

create table dept03(
deptno number(2),
dname varchar2(14),
loc varchar2(13))

create table emp02
as 
select * from emp;

create table emp03
as
select empno, ename from emp;

create table emp04
as
select empno, ename, sal
from emp;

select * from emp04;

create table emp05
as
select *
from emp
where deptno = 10;

create table dept05
as
select *
from dept
where 1=0;

select *
from dept05;

select * from emp01;

alter table emp01
add (job varchar2(9));

select * from emp01;

alter table dept02
add (dmgr number(4));

select * from dept02;

alter table emp01
modify(job varchar2(30));

select * from emp01;

alter table dept02
modify(dmgr number(4));

select * from dept02;

alter table emp01
drop column job;

alter table dept02
drop column job

alter table dept02
drop column dmgr;

alter table emp02
set unused(job);

alter table emp02
drop unused columns;

select * from emp02;

drop table emp01;

select * from emp01;

truncate table emp02;

rename emp02 to test;

select * from test;