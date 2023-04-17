-- Find the supplier-customer pair(s) with the least expensive (o totalprice) order(s) completed (F in
-- o orderstatus). Print the supplier name, the customer name, and the total price.
SELECT s_name, c_name, MIN(o_totalprice)
FROM supplier s, customer c, lineitem l, orders o
WHERE c.c_custkey = o.o_custkey
AND o.o_orderstatus = 'F'
AND s.s_suppkey = l.l_suppkey
AND l.l_orderkey = o.o_orderkey