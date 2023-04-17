-- Based on the available quantity of items, who is the manufacturer p mfgr of the most popular item
-- (the more popular an item is, the less available it is in ps availqty) from Supplier#000000010?
SELECT p_mfgr
FROM partsupp ps join supplier s on s.s_suppkey = ps.ps_suppkey
join part p on ps.ps_partkey = p.p_partkey
WHERE
ps_availqty = (SELECT MIN(ps_availqty) FROM partsupp, supplier WHERE s_name = 'Supplier#000000010' AND s_suppkey = ps_suppkey) AND
s_name = 'Supplier#000000010'