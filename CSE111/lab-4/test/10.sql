-- Find the minimum and maximum discount for every part having ECONOMY and COPPER in its type.
select p.p_type, min(l.l_discount), max(l.l_discount) from lineitem l 
JOIN part p on l.l_partkey = p.p_partkey
WHERE p.p_type LIKE '%ECONOMY%' and p.p_type LIKE '%COPPER%'
GROUP BY p.p_type