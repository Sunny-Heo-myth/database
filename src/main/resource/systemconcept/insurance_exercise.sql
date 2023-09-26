# 3.4.a Find the total number of people who owned cars that were involved in accidents in 2017.
select count(distinct x.pid) as cnt
from (select p.driver_id as pid
      from person p,
           owns o,
           car c,
           participated pt,
           accident a
      where p.driver_id = o.driver_id
        and o.licence_plate = c.licence_plate
        and c.licence_plate = pt.licence_plate
        and pt.report_number = a.report_number
        and a.year = 2017
      group by pid) as x;

# 3.4.b Delete all year-2010 cars belonging to the person whose ID is '12345'.
delete from car
where licence_plate in (
    select c.licence_plate
    from (select * from car) as c, owns o, person p # mysql problem
    where c.licence_plate = o.licence_plate
      and o.driver_id = p.driver_id
      and p.driver_id = '12345'
      and c.year = '2010'
);

# 3.14.a
# Find the number of accidents involving a car belonging to a person named “John Smith”.
select count(*) as accident_cnt
from car c,
     person p,
     participated pt,
     accident a
where c.licence_plate = pt.licence_plate
  and p.driver_id = pt.driver_id
  and pt.report_number = a.report_number
  and p.name = 'John Smith';

# 3.14.b
# Update the damage amount for the car with license plate “AABB2000”
# in the accident with report number “AR2197” to $3000.