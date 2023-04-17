--  Find the number of distinct orders completed in 1995 by the suppliers in every nation. An order status
-- of F stands for complete. Print only those nations for which the number of orders is larger than 50
SELECT n.n_name, count(DISTINCT o.o_orderkey) from supplier s
JOIN nation n on s.s_nationkey = n.n_nationkey
JOIN lineitem l on l.l_suppkey = s.s_suppkey
JOIN orders o on o.o_orderkey = l.l_orderkey
WHERE strftime("%Y", o.o_orderdate) = '1995' and o.o_orderstatus = 'F'
GROUP BY n.n_name
having COUNT(DISTINCT o.o_orderkey) > 50
