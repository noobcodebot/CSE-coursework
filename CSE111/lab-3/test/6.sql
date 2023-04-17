-- What are the nations of the customers that made orders between September 9-11, 1994? Print every
-- nation only once and sort them in alphabetical order.
SELECT DISTINCT n_name
from customer c1 join orders o1 on o1.o_custkey = c1.c_custkey
join nation n1 on n_nationkey = c_nationkey
where o1.o_orderdate = "1994-09-09" or o1.o_orderdate = "1994-09-10" or o1.o_orderdate = "1994-09-11"
group by n_name