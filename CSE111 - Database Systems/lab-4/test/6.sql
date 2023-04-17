-- How many unique parts produced by every supplier in CANADA are ordered at every priority? Print the
-- supplier name, the order priority, and the number of parts.
SELECT s.s_name, o.o_orderpriority, count(DISTINCT p_partkey)
FROM part p JOIN lineitem l on l.l_partkey = p.p_partkey
JOIN supplier s on s.s_suppkey = l.l_suppkey
JOIN nation n on s.s_nationkey = n.n_nationkey
JOIN orders o on o.o_orderkey = l.l_orderkey
WHERE n.n_name = 'CANADA' 
GROUP BY s.s_name, o.o_orderpriority