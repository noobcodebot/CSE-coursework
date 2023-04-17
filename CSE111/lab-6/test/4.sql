-- Find how many suppliers from UNITED STATES supply more than 40 different parts.
select count (cnt.s_suppkey) FROM
(select s.s_suppkey from supplier s join partsupp ps 
on ps.ps_suppkey = s.s_suppkey join part p on 
ps.ps_partkey = p.p_partkey JOIN
nation n on s.s_nationkey = n.n_nationkey
where n.n_name = "UNITED STATES"
group by s.s_suppkey
having count(DISTINCT p.p_partkey) > 40) as cnt