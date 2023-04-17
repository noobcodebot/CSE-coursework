-- How many line items ordered by Customer#000000020 were received every month? Print the number
-- of ordered line items corresponding to every (year, month) pair from l_receiptdate.
select strftime('%Y-%m', l_receiptdate), count(l_receiptdate) from lineitem l inner join orders o on 
o.o_orderkey = l.l_orderkey inner join customer c on c.c_custkey = o.o_custkey
where (strftime('%Y', l_receiptdate) AND c.c_name = 'Customer#000000020')
GROUP BY strftime('%Y-%m', l_receiptdate);