-- Find how many parts are supplied by exactly two suppliers from UNITED STATES.
select count (cnt.p_partkey) FROM
(select p.p_partkey from partsupp ps join part p
on ps.ps_partkey = p.p_partkey join supplier s ON
s.s_suppkey = ps.ps_suppkey join nation n ON
s.s_nationkey = n.n_nationkey
where n.n_name = "UNITED STATES"
group by p.p_partkey
HAVING count(distinct s.s_suppkey) = 2) as cnt