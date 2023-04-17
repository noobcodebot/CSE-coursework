-- How many different order clerks did the suppliers in UNITED STATES work with?
select count(distinct o.o_clerk) from orders o 
JOIN lineitem l on l.l_orderkey = o.o_orderkey 
JOIN supplier s on s.s_suppkey = l.l_suppkey
JOIN nation n on n.n_nationkey = s.s_nationkey
where n.n_name = 'UNITED STATES'