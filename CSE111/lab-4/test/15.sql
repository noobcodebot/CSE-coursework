-- How many distinct orders are between customers with positive account balance and suppliers with
-- negative account balance?
select count(distinct o.o_orderkey) from orders o
JOIN lineitem l on l.l_orderkey = o.o_orderkey
JOIN supplier s on l.l_suppkey = s.s_suppkey
JOIN customer c on c.c_custkey = o_custkey
WHERE c.c_acctbal > 0 and s.s_acctbal < 0