-- Find how many 1-URGENT priority orders have been posted by customers from PERU between 1995 and
-- 1997, combined.
select count(*) from orders o join customer c
on o.o_custkey = c.c_custkey join nation n on c.c_nationkey = n.n_nationkey
where (n.n_name = 'PERU' and o.o_orderpriority='1-URGENT') and ((strftime("%Y", o.o_orderdate) = '1997')
or (strftime("%Y", o.o_orderdate) = '1995') or (strftime("%Y", o.o_orderdate) = '1996'))