select employee_id, first_name, last_name, job_id, salary
from employees
where salary >= 10000
order by job_id, employee_id;

select employee_id, email || '@samsung.com' as "e-mail"
from employees
order by employee_id;

select department_id, round(avg(salary)) as "avg_salary"
from employees
group by department_id
having count(department_id) >= 5
order by department_id;

alter table employees add next_salary number(8);

insert into employees(next_salary) values 
(select salary * 1.3 from employees where department_id = 30);
insert into employees(next_salary) values 
(select salary * 1.5 from employees where department_id = 50);
insert into employees(next_salary) values 
(select salary * 0.9 from employees where department_id = 80);

select employee_id, first_name, last_name, department_id, salary
from employees
where salary = (select max(salary) from employees);

