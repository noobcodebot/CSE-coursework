-- Find the number of customers that received a discount of at least 7% for one 
-- of the line items on their orders. Count every customer exactly once even if they 
-- have multiple discounted line items.
SELECT sum(mycount) from
(SELECT count(DISTINCT c.c_custkey) as mycount from customer c join orders o
on c.c_custkey = o.o_custkey join lineitem l 
on o.o_orderkey = l.l_orderkey
where l.l_discount >= 0.07
group by c.c_custkey);