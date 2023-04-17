SELECT n.n_name
from supplier s join nation n on s.s_nationkey = n.n_nationkey
join lineitem l on l.l_suppkey = s.s_suppkey
join orders o on l.l_orderkey = o.o_orderkey
WHERE l.l_shipdate between '1996-01-01' AND '1996-12-31'
GROUP BY n.n_name 
ORDER BY SUM(l_extendedprice) DESC
LIMIT 1