-- How many parts with size below 20 does every supplier from CANADA offer? Print the name of the
-- supplier and the number of parts.
SELECT s.s_name, COUNT(*) FROM partsupp ps JOIN supplier s
ON s.s_suppkey = ps.ps_suppkey 
JOIN part p on ps.ps_partkey = p.p_partkey
JOIN nation n on n.n_nationkey= s.s_nationkey
WHERE p.p_size < 20 and n.n_name = 'CANADA'
GROUP BY s.s_name