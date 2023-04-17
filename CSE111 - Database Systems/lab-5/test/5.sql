-- For parts whose type contains STEEL, return the name of the supplier from ASIA that can supply them
-- at minimum cost (ps supplycost), for every part size. Print the supplier name together with the part
-- size and the minimum cost.
select s.s_name, p.p_size, min(ps.ps_supplycost) from supplier s
join partsupp ps on s.s_suppkey = ps.ps_suppkey
join part p on ps.ps_partkey = p.p_partkey
join nation n on n.n_nationkey = s.s_nationkey
join region r on n.n_regionkey = r.r_regionkey
where p.p_type LIKE '%STEEL%' and r.r_name = 'ASIA'
group by p.p_size
order BY s.s_name
