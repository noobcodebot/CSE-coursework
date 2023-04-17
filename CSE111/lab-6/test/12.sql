SELECT oput2.name FROM (
SELECT oput1.n_name as name, MIN(oput1.tot)
FROM (SELECT n_name, SUM(o_totalprice) as tot FROM orders, nation, customer WHERE n_nationkey = c_nationkey AND o_custkey = c_custkey GROUP BY n_name) as oput1
) as oput2