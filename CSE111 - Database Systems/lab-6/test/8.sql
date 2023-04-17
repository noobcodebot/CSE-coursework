-- Find how many distinct customers have at least one order supplied exclusively by suppliers from
-- AMERICA.
select count(DISTINCT(o_custkey))
from orders where o_orderkey NOT in (
    select distinct o.o_orderkey FROM
    lineitem l join supplier s on l.l_suppkey = s.s_suppkey
    join orders o on o.o_orderkey = l.l_orderkey
    join nation n on s.s_nationkey = n.n_nationkey
    join region r on r.r_regionkey = n.n_regionkey
    where r.r_name not in ('AMERICA')
)