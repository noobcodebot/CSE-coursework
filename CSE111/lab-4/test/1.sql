-- Find the total price paid on orders by every customer from FRANCE in 1995. Print the customer name
-- and the total price.
SELECT c.c_name, sum(o.o_totalprice) from orders o JOIN
customer c on c.c_custkey = o.o_custkey
JOIN nation n on c.c_nationkey = n.n_nationkey
where n.n_name = 'FRANCE' and strftime("%Y", o.o_orderdate) = '1995'
group by c.c_name