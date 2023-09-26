
# 3.8.a Find the ID of each customer of the bank who has an account but not a loan.
select c.ID
from customer c, borrower b, depositor d
where c.ID = b.ID
  and c.ID = d.ID
  and c.ID not in (
    select ID
    from borrower
)
  and (
          select count(*)
          from depositor dd
          where c.ID = dd.ID
      ) = 1;
# lateral?

# 3.8.b Find the ID of each customer who lives on the same street and in the same city as customer '12345'.
select c1.ID
from customer c1
where (customer_street, customer_city) = (select customer_street, customer_city
                                          from customer c2
                                          where c2.ID = '12345');

# 3.8.c Find the name of each branch that has at least one customer who has an account in the bank and who lives in “Harrison”.
select distinct b.branch_name
from branch b, account a, depositor d, customer c
where b.branch_name = a.branch_name
  and a.account_number = d.account_number
  and d.ID = c.ID
  and c.customer_city = 'Harrison';