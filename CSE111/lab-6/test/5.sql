-- Find how many suppliers supply the most expensive part (p retailprice)
select count(DISTINCT s.s_suppkey)
from supplier s
join partsupp ps
on ps.ps_suppkey = s.s_suppkey
join part p
on ps.ps_partkey = p.p_partkey
join nation n
on s.s_nationkey = n.n_nationkey
where p.p_retailprice = (SELECT max(p_retailprice) from part)