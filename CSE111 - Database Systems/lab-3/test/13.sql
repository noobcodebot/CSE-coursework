-- Find the total account balance of all the customers from ASIA in the MACHINERY market segment.
select sum(c_acctbal)from customer c 
join nation n on n.n_nationkey = c.c_nationkey join region r 
on r.r_regionkey = n.n_regionkey
where  c.c_mktsegment='MACHINERY' and r.r_name='ASIA'
