-- Find the name of the suppliers from EUROPE who have more than $7000 on account balance. Print the
-- supplier name and their account balance.
select s_name, s_acctbal from supplier s 
join nation n on n.n_nationkey = s.s_nationkey
join region r on r.r_regionkey = n.n_regionkey
where r_name = 'EUROPE' and s.s_acctbal > 7000


