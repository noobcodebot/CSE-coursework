-- How many line items are supplied by suppliers in AFRICA for orders made by customers in UNITED
-- STATES?
SELECT count(*)
FROM customer c
JOIN orders o on c.c_custkey = o.o_custkey
JOIN supplier s on s.s_suppkey = l.l_suppkey
JOIN nation cn on c.c_nationkey = cn.n_nationkey
JOIN region r on cn.n_regionkey = r.r_regionkey
JOIN nation sn on s.s_nationkey = sn.n_nationkey
JOIN lineitem l on l.l_orderkey = o.o_orderkey
WHERE cn.n_name = 'UNITED STATES' and sn.n_regionkey = 0
