SELECT o_orderpriority, COUNT(DISTINCT o_orderkey)
FROM orders, lineitem
WHERE
(julianday(l_commitdate) - julianday(l_receiptdate)) > 0 AND
o_orderdate BETWEEN '1997-10-01' AND '1997-12-31' AND
l_orderkey = o_orderkey
GROUP BY
o_orderpriority