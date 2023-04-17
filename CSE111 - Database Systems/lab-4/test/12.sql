-- What is the maximum account balance for the suppliers in every nation? Print only those nations for
-- which the maximum balance is larger than 9000.
select n.n_name, max(s.s_acctbal) from nation n 
JOIN supplier s on s.s_nationkey = n.n_nationkey
group by n.n_name
having max(s.s_acctbal) > 9000