--Find the supplier with the largest account balance in every region. Print the region name, the supplier
--name, and the account balance.
SELECT r.r_name, s.s_name, max(distinct s.s_acctbal) from region r
JOIN nation n on n.n_regionkey = r.r_regionkey
JOIN supplier s on s.s_nationkey = n.n_nationkey 
GROUP BY r.r_name