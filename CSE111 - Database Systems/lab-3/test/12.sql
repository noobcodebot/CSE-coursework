-- Find the number of orders having status P. Group these orders based on the region of the customer
-- who posted the order. Print the region name and the number of status P orders.
SELECT r.r_name, count(*) from orders o 
join customer c on c.c_custkey = o.o_custkey
join nation n on c.c_nationkey = n.n_nationkey
join region r on r.r_regionkey = n.n_regionkey
where o.o_orderstatus='P'
group by r.r_name