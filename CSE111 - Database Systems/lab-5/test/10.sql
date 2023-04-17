-- How many customers from every region have never placed an order and have less than the average
-- account balance?
SELECT r.r_name, COUNT(c.c_custkey)
FROM customer c join nation n on 
c.c_nationkey = n.n_nationkey join region r ON
n.n_regionkey = r.r_regionkey,
( SELECT AVG(c_acctbal) AS c FROM customer) bals
LEFT JOIN orders ON c_custkey = o_custkey
WHERE o_custkey is NULL
AND c_nationkey = n_nationkey AND n_regionkey = r_regionkey
AND c_acctbal < bals.c
GROUP BY r_name;