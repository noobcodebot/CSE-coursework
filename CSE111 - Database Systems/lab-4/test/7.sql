-- How many orders do customers in every nation in AMERICA have in every status? Print the nation
-- name, the order status, and the count
SELECT n.n_name, o.o_orderstatus, count(*) 
FROM nation n JOIN customer c ON c.c_nationkey = n.n_nationkey
JOIN orders o on c.c_custkey = o.o_custkey
JOIN region r on r.r_regionkey = n.n_regionkey
where r.r_name = 'AMERICA'
GROUP BY n.n_nationkey, o.o_orderstatus