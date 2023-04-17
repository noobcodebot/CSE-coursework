-- How many customers and suppliers are in every country from AFRICA
select n.n_name, count(distinct c.c_custkey), count(distinct s.s_suppkey) from customer c join supplier s on 
c.c_nationkey = s.s_nationkey join nation n ON
n.n_nationkey = s.s_nationkey join region r ON
n.n_regionkey = r.r_regionkey
where r.r_name = 'AFRICA'
group by n.n_name
