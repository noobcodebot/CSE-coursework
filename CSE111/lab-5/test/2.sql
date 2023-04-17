-- How many suppliers in every region have less balance in their account than the average account balance
-- of their own region?
-- select r.r_name, count(distinct s.s_suppkey) from supplier s join nation n
-- on s.s_nationkey = n.n_nationkey join region r 
-- on n.n_regionkey = r.r_regionkey
-- where 
-- (select avg(s.s_acctbal) from supplier s join nation n on
-- s.s_nationkey = n.n_nationkey join region r on n.n_regionkey = r.r_regionkey
-- where r.r_name = 'AFRICA') > s.s_acctbal and r.r_name = 'AFRICA'
-- union 
-- select r.r_name, count(distinct s.s_suppkey) from supplier s join nation n
-- on s.s_nationkey = n.n_nationkey join region r 
-- on n.n_regionkey = r.r_regionkey
-- where 
-- (select avg(s.s_acctbal) from supplier s join nation n on
-- s.s_nationkey = n.n_nationkey join region r on n.n_regionkey = r.r_regionkey
-- where r.r_name = 'ASIA') > s.s_acctbal and r.r_name = 'ASIA'
-- union
-- select r.r_name, count(distinct s.s_suppkey) from supplier s join nation n
-- on s.s_nationkey = n.n_nationkey join region r 
-- on n.n_regionkey = r.r_regionkey
-- where 
-- (select avg(s.s_acctbal) from supplier s join nation n on
-- s.s_nationkey = n.n_nationkey join region r on n.n_regionkey = r.r_regionkey
-- where r.r_name = 'AMERICA') > s.s_acctbal and r.r_name = 'AMERICA'
-- UNION
-- select r.r_name, count(distinct s.s_suppkey) from supplier s join nation n
-- on s.s_nationkey = n.n_nationkey join region r 
-- on n.n_regionkey = r.r_regionkey
-- where 
-- (select avg(s.s_acctbal) from supplier s join nation n on
-- s.s_nationkey = n.n_nationkey join region r on n.n_regionkey = r.r_regionkey
-- where r.r_name = 'EUROPE') > s.s_acctbal and r.r_name = 'EUROPE'
-- union
-- select r.r_name, count(distinct s.s_suppkey) from supplier s join nation n
-- on s.s_nationkey = n.n_nationkey join region r 
-- on n.n_regionkey = r.r_regionkey
-- where 
-- (select avg(s.s_acctbal) from supplier s join nation n on
-- s.s_nationkey = n.n_nationkey join region r on n.n_regionkey = r.r_regionkey
-- where r.r_name = 'MIDDLE EAST') > s.s_acctbal and r.r_name = 'MIDDLE EAST'

SELECT region.r_name, COUNT(supplier.s_suppkey)
FROM supplier, region, nation, ( SELECT r_regionkey, avg(s_acctbal) as AR FROM region, supplier, nation WHERE s_nationkey = n_nationkey AND n_regionkey = r_regionkey GROUP by r_name ) as averageR
WHERE supplier.s_nationkey = nation.n_nationkey
AND averageR.r_regionkey = region.r_regionkey
AND nation.n_regionkey = region.r_regionkey
AND supplier.s_acctbal < averageR.AR
GROUP BY region.r_name;