-- List the maximum total price of an order between any two regions, i.e., the suppliers are from one
-- region and the customers are from the other region.
SELECT sr.r_name, cr.r_name, max(distinct o.o_totalprice)
FROM customer c, supplier s, region cr, region sr, orders o, lineitem l, nation cn, nation sn, region r
WHERE
c.c_custkey = o.o_custkey AND
s.s_suppkey = l.l_suppkey AND
l.l_orderkey = o.o_orderkey AND
s.s_nationkey = sn.n_nationkey AND
c.c_nationkey = cn.n_nationkey AND 
sn.n_regionkey = sr.r_regionkey AND 
cn.n_regionkey = cr.r_regionkey
GROUP BY  sr.r_name, cr.r_name