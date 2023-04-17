-- Find the number of suppliers from every region.
SELECT r.r_name, COUNT(*) FROM nation n JOIN supplier s
ON s.s_nationkey = n.n_nationkey 
JOIN region r on n.n_regionkey = r.r_regionkey
GROUP BY r.r_regionkey