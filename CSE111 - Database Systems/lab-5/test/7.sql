-- For every order priority, count the number of parts ordered in 1997 and received later (l receiptdate)
-- than the commit date (l commitdate)
select o.o_orderpriority, COUNT(o.o_orderkey)
from orders o join lineitem l on 
o.o_orderkey = l.l_orderkey 
WHERE
(julianday(l.l_receiptdate) - julianday(l.l_commitdate)) > 0 
AND
o.o_orderdate between '1997-01-01' AND '1997-12-31'
group by o.o_orderpriority;