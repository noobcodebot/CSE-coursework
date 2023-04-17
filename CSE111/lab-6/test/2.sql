-- Find the number of customers who had at least three orders in November 1995 (o orderdate).
SELECT COUNT(cnt.c_custkey) FROM
(SELECT c.c_custkey from customer c JOIN
orders o on o.o_custkey = c.c_custkey
where strftime("%Y-%m", o.o_orderdate) = "1995-11"
group by c.c_custkey
having count(c.c_custkey)>=3) as cnt
