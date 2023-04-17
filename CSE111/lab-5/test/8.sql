-- Count the number of distinct suppliers that supply parts whose type contains POLISHED and have size
-- equal to any of 3, 23, 36, and 49.
SELECT COUNT(DISTINCT s.s_name)
FROM supplier s join partsupp ps on ps.ps_suppkey = s.s_suppkey
join part p on p.p_partkey = ps.ps_partkey
WHERE
p_size IN (3, 23, 36, 49) AND
p_type LIKE '%POLISHED%'