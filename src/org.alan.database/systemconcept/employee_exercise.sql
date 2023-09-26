
# 3.9.a Find the ID, name, and city of residence of each employee who works for “First Bank Corporation”.
select e.ID, e.person_name, e.city
from employee e, works w
where e.ID = w.id
  and w.company_name = 'First Bank Corporation';

# 3.9.b Find the ID, name, and city of residence of each employee who works for “First Bank Corporation” and earns more than $10000.
select e.ID, e.person_name, e.city
from employee e, works w
where e.ID = w.id
  and w.company_name = 'First Bank Corporation'
  and w.salary > 10000;

# 3.9.c Find the ID of each employee who does not work for “First Bank Corporation”.
select ID
from employee
where ID not in (select w.ID
                 from works w
                 where w.company_name = 'First Bank Corporation');

# 3.9.d Find the ID of each employee who earns more than every employee of “Small Bank Corporation”.
select ID
from works
where salary > all (select salary
                    from works
                    where company_name = 'Small Bank Corporation');

# *** 3.9.e Assume that companies may be located in several cities. (City is also an attribute of pk.)
# Find the name of each company that is located in every city in which “Small Bank Corporation” is located.
select a.company_name
from company a
where not exists (select *
                  from company b
                  where b.company_name = 'Small Bank Corporation'
                    and b.city not in (select c.city
                                       from company c
                                       where c.city = a.city));

# select S.company_name
# from company as S
# where not exists ((select city
#                    from company
#                    where company_name = 'Small Bank Corporation')
#                    except
#                   (select city
#                    from company as T
#                    where S.company_name = T.company_name))

# 3.9.f Find the name of the company that has the most employees
# (or companies, in the case where there is a tie for the most).
with x as (
    select c.company_name as name, count(*) as head_count
    from company c, works w
    where c.company_name = w.company_name
    group by c.company_name
)
select name
from x
where head_count = (select max(head_count)
                    from x);

# 3.9.g Find the name of each company whose employees earn a higher salary, on average,
# than the average salary at “First Bank Corporation”.
select average.company_name
from (select c.company_name as company_name, avg(w.salary) as avg_salary
      from company c,
           works w
      where c.company_name = w.company_name
      group by c.company_name) as average
where average.avg_salary > (select avg(salary) as average_salary
                            from company c,
                                 works w
                            where c.company_name = w.company_name
                              and c.company_name = 'First Bank Corporation');

# 3.10.a Modify the database so that the employee whose ID is '12345' now lives in “Newtown”.
update employee e
set city = 'Newtown'
where e.ID = '12345';

# 3.10.b Give each manager of “First Bank Corporation” a 10 percent raise unless the salary becomes greater than $100000;
# in such cases, give only a 3 percent raise.
update employee e, manages m, works w
set w.salary = IF(w.salary <= 90909, w.salary * 1.1, w.salary * 1.03)
where e.ID = m.manager_id
  and e.ID = w.ID
  and w.company_name = 'First Bank Corporation';
