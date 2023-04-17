-- Find the number of orders posted by every customer from GERMANY in 1993
SELECT c.c_name, COUNT(*) FROM customer c
JOIN nation n
ON c.c_nationkey = n.n_nationkey
JOIN orders o 
ON o.o_custkey = c.c_custkey
WHERE strftime('%Y', o.o_orderdate) = '1993' and n.n_name = 'GERMANY'
GROUP BY c.c_name