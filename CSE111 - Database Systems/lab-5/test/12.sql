--What is the total supply cost (ps supplycost) for parts less expensive than $1000 (p retailprice) shipped
--in 1997 (l shipdate) by suppliers who did not supply any line item with an extended price less than
--2000 in 1996?
SELECT SUM(ps_supplycost)
FROM part, partsupp
WHERE
p_partkey = ps_partkey AND
p_retailprice < 1000 AND
p_partkey IN( SELECT l_partkey FROM lineitem, partsupp WHERE ps_suppkey = l_suppkey AND l_shipdate BETWEEN '1997-01-01' AND '1997-12-31') 
AND ps_suppkey 
NOT IN( SELECT DISTINCT ps_suppkey FROM partsupp, lineitem, part WHERE ps_partkey = p_partkey 
AND p_partkey = l_partkey AND ps_suppkey = l_suppkey
AND l_extendedprice < 2000
AND l_shipdate 
BETWEEN '1996-01-01' AND '1996-12-31')
