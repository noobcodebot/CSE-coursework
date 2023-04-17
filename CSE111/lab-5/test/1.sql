-- How many customers are not from EUROPE or AFRICA or ASIA?
select count(*) from customer c join nation n 
on c.c_nationkey = n.n_nationkey JOIN
region r on n.n_regionkey = r.r_regionkey
where r.r_name != 'EUROPE' and r.r_name != 'AFRICA' and r.r_name != 'ASIA'