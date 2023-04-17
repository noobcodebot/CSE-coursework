select distinct oput.r_name
from (select r_name from 
supplier s join nation n on s.s_nationkey = n.n_nationkey
join lineitem l on l.l_suppkey = s.s_suppkey 
join customer c on c.c_nationkey = s.s_nationkey
join region r on r.r_regionkey = n.n_regionkey
and l.l_extendedprice = (SELECT min(l_extendedprice) from lineitem)
) as oput