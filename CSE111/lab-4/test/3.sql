-- How many orders are posted by customers in every country in AMERICA
SELECT n.n_name, count(*) from customer c 
JOIN orders o on c.c_custkey = o.o_custkey
JOIN nation n on c.c_nationkey = n.n_nationkey
JOIN region r on n.n_regionkey = r.r_regionkey
where r.r_name = 'AMERICA'
GROUP BY n.n_name