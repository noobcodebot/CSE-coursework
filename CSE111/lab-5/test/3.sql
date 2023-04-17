-- For the line items ordered in October 1996 (o orderdate), find the smallest discount that is larger
-- than the average discount among all the orders.
select min(l.l_discount) from lineitem l join orders o 
on l.l_orderkey = o.o_orderkey where
(SELECT avg(l.l_discount) from lineitem l join orders o on l.l_orderkey = o.o_orderkey
where strftime('%Y-%m',o.o_orderdate) = '1996-10') < l.l_discount

