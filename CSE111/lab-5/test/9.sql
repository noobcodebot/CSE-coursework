-- Print the name of the parts supplied by suppliers from UNITED STATES that have total value in the top
-- 1% total values across all the supplied parts. The total value is ps supplycost*ps availqty. Hint:
-- Use the LIMIT keyword.
SELECT p_name 
FROM partsupp ps join supplier s on s.s_suppkey = ps.ps_suppkey
JOIN nation n on s.s_nationkey = n.n_nationkey
JOIN part p on ps.ps_partkey = p.p_partkey
WHERE
n_name = 'UNITED STATES' AND
ps_supplycost * ps_availqty IN (SELECT ps_supplycost * ps_availqty FROM partsupp ORDER BY ps_supplycost * ps_availqty DESC LIMIT (SELECT COUNT(*) * 0.01 FROM partsupp))