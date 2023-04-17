-- Find how many suppliers have less than 50 distinct orders from customers in GERMANY and FRANCE
-- together
select count(cnt.s_suppkey)
from (
    select s.s_suppkey
    from lineitem l join orders o
    on l.l_orderkey = o.o_orderkey
    join supplier s on s.s_suppkey = l.l_suppkey
    join customer c on c.c_custkey = o.o_custkey
    join nation n on c.c_nationkey = n.n_nationkey
    where n.n_name IN ("GERMANY", "FRANCE")
    group by s.s_suppkey
    having count(DISTINCT o.o_orderkey) < 50
) as cnt