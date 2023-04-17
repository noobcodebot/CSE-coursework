-- Find the total price o_totalprice of orders made by customers from ASIA in 1997.
select sum(o_totalprice) from orders o join customer c
on o.o_custkey = c.c_custkey join nation n on 
c.c_nationkey = n.n_nationkey join region r ON
r.r_regionkey = n.n_regionkey
where (strftime('%Y', o.o_orderdate) = '1997') and r.r_name = 'ASIA'