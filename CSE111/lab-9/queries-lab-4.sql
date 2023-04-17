-- SQLite
DROP VIEW V1;
DROP VIEW V2;
DROP VIEW V5;
DROP VIEW V10;
DROP VIEW V151;
DROP VIEW V152;
--1
select c_name, sum(o_totalprice)
from orders, customer, nation
where o_custkey = c_custkey and
	n_nationkey = c_nationkey and
	n_name = 'FRANCE' AND
	o_orderdate like '1995-__-__'
group by c_name;

-- SELECT p.p_partkey, p.p_type, MIN(l.l_discount), MAX(l.l_discount)
-- FROM Part p JOIN Lineitem l 
-- ON p.p_partkey = l.l_partkey
-- GROUP BY p.p_type

--2
select r_name, count(*)
from supplier, nation, region
where s_nationkey = n_nationkey
    and n_regionkey = r_regionkey
group by r_name;

--3
select n_name, count(*)
from orders, nation, region, customer
where c_custkey = o_custkey
    and c_nationkey = n_nationkey
    and n_regionkey = r_regionkey
    and r_name='AMERICA'
group by n_name;

--4
select s_name, count(ps_partkey)
from partsupp, supplier, nation, part
where p_partkey = ps_partkey
    and ps_suppkey = s_suppkey
    and s_nationkey = n_nationkey
    and n_name = 'CANADA'
    and p_size < 20
group by s_name;

-- SELECT s_name, count(ps_partkey) FROM V2, partsupp, part
-- WHERE p_partkey = ps_partkey
--     and ps_suppkey = s_suppkey
--     and s_nation = 'CANADA'
--     and p_size <20
-- GROUP BY s_name

--5
select c_name, count(*)
from orders, customer, nation
where o_custkey = c_custkey
    and c_nationkey = n_nationkey
    and n_name = 'GERMANY'
    and o_orderdate like '1993-__-__'
group by c_name;

-- SELECT c_name, count(*)
-- FROM V1, V5
-- WHERE c_custkey = o_custkey
--     AND c_nation = 'GERMANY'
--     AND o_orderyear like '1993-__-__'
-- GROUP BY c_name

--6
select s_name, o_orderpriority, count(distinct ps_partkey)
from partsupp, orders, lineitem, supplier, nation
where l_orderkey = o_orderkey
    and l_partkey = ps_partkey
    and l_suppkey = ps_suppkey
    and ps_suppkey = s_suppkey
    and s_nationkey = n_nationkey
    and n_name = 'CANADA'
group by s_name, o_orderpriority;

-- SELECT s_name, o_orderpriority, count(distinct ps_partkey)
-- FROM V2, V5, partsupp, lineitem
-- WHERE l_orderkey = o_orderkey
--     and l_partkey = ps_partkey
--     and l_suppkey = ps_suppkey
--     and ps_suppkey = s_suppkey
--     and s_nation = 'CANADA'
-- GROUP BY s_name, o_orderpriority

--7
select n_name, o_orderstatus, count(*)
from orders, customer, nation, region
where o_custkey = c_custkey
    and c_nationkey = n_nationkey
    and n_regionkey = r_regionkey
    and r_name='AMERICA'
group by n_name, o_orderstatus;

-- SELECT c_nation, o_orderstatus, count(*)
-- FROM V1, V5
-- WHERE o_custkey = c_custkey
--     AND c_region = 'AMERICA'
-- group by c_nation, o_orderstatus;

--8
select n_name, count(distinct l_orderkey) as co
from orders, nation, supplier, lineitem
where o_orderkey = l_orderkey
    and l_suppkey = s_suppkey
    and s_nationkey = n_nationkey
    and o_orderstatus = 'F'
    and o_orderdate like '1995-__-__'
group by n_name
having co > 50;

-- SELECT s_nation, count(distinct l_orderkey) as co 
-- FROM V2, V5, lineitem
-- where o_orderkey = l_orderkey
--     and l_suppkey = s_suppkey
-- and o_orderstatus = 'F'
--     and o_orderyear like '1995-__-__'
-- group by s_nation
-- having co > 50;

--9
select count(distinct o_clerk)
from orders, supplier, nation, lineitem
where o_orderkey = l_orderkey
    and l_suppkey = s_suppkey
    and s_nationkey = n_nationkey
    and n_name = 'UNITED STATES';


SELECT count(distinct o_clerk)
FROM V2, V5, lineitem
WHERE o_orderkey = l_orderkey
    AND l_suppkey = s_suppkey
    AND s_nation = 'UNITED STATES'

--10
select p_type, min(l_discount), max(l_discount)
from lineitem, part
where l_partkey = p_partkey
    and p_type like '%ECONOMY%'
    and p_type like '%COPPER%'
group by p_type;

-- SELECT p_type, min_discount, max_discount
-- FROM V10
-- WHERE p_type like '%ECONOMY%'
--     AND p_type like '%COPPER%'
-- GROUP BY p_type

--11
select r.r_name, s.s_name, s.s_acctbal
from supplier s, nation n, region r
where s.s_nationkey = n.n_nationkey
        and n.n_regionkey = r.r_regionkey
        and s.s_acctbal = (select max(s1.s_acctbal)
							from supplier s1, nation n1, region r1
							where s1.s_nationkey = n1.n_nationkey
								and n1.n_regionkey = r1.r_regionkey
								and r.r_regionkey = r1.r_regionkey
						);

-- SELECT s.s_region, s.s_name, s.s_acctbal
-- FROM V2 s
-- WHERE s_acctbal = (SELECT max(s1.s_acctbal)
--                     from supplier s1, nation n1, region r1
-- 							where s1.s_nationkey = n1.n_nationkey
-- 								and n1.n_regionkey = r1.r_regionkey
-- 								and s_region = r1.r_name)

--12
select n_name, max(s_acctbal) as mb
from supplier, nation
where s_nationkey = n_nationkey
group by n_name
having mb > 9000;

-- SELECT s_nation, max(s_acctbal) as mb 
-- FROM V2
-- GROUP BY s_nation
-- having mb > 9000;

--13
select count(*)
from orders, lineitem, customer, supplier, nation n1, region, nation n2
where o_orderkey = l_orderkey
    and o_custkey = c_custkey
    and l_suppkey = s_suppkey
    and s_nationkey = n1.n_nationkey
    and n1.n_regionkey = r_regionkey
    and c_nationkey = n2.n_nationkey
    and r_name = 'AFRICA'
    and n2.n_name = 'UNITED STATES';


-- SELECT COUNT(*)
-- FROM V1, V2, lineitem, nation n1, nation n2, region r, orders
-- where o_orderkey = l_orderkey
-- and o_custkey = c_custkey
--     and l_suppkey = s_suppkey
--     and s_nation = n1.n_name
--     and n1.n_regionkey = r_regionkey
--     and c_nation = n2.n_name
--     and r_name = 'AFRICA'
--     and n2.n_name = 'UNITED STATES';


--14
select r1.r_name as suppRegion, r2.r_name as custRegion, max(o_totalprice)
from lineitem, supplier, orders, customer, nation n1, region r1, nation n2, region r2
where l_suppkey = s_suppkey
    and s_nationkey = n1.n_nationkey
    and n1.n_regionkey = r1.r_regionkey
    and l_orderkey = o_orderkey
    and o_custkey = c_custkey
    and c_nationkey = n2.n_nationkey
    and n2.n_regionkey = r2.r_regionkey
group by r1.r_name, r2.r_name;

SELECT s_region as suppRegion, c_region as custRegion, max(o_totalprice)
FROM V1, V2, orders, lineitem
WHERE l_suppkey = s_suppkey
    and l_orderkey = o_orderkey
    and o_custkey = c_custkey
group by s_region, c_region;

--15
select count(distinct l_orderkey)
from lineitem, supplier, orders, customer
where l_suppkey = s_suppkey
    and l_orderkey = o_orderkey
    and o_custkey = c_custkey
    and c_acctbal > 0
    and s_acctbal < 0;

SELECT count(DISTINCT l_orderkey)
FROM lineitem, V151, V152, orders
where l_suppkey = s_suppkey
    and l_orderkey = o_orderkey
    and o_custkey = c_custkey
    and c_acctbal > 0
    and s_acctbal < 0;
