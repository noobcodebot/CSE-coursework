-- Find the total number of line items on orders with priority 3-MEDIUM supplied by suppliers from
-- GERMANY and FRANCE. Group these line items based on the year of the order from o orderdate. Print
-- the year and the count. Check the substr function in SQLite.
select strftime('%Y', o.o_orderdate), count(*) from lineitem l join orders o on l.l_orderkey = o.o_orderkey
join supplier s on s.s_suppkey = l.l_suppkey join nation n on s.s_nationkey = n.n_nationkey
where (n.n_name = 'GERMANY' or n.n_name = 'FRANCE') and o.o_orderpriority='3-MEDIUM'
group by strftime('%Y', o.o_orderdate)