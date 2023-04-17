-- Find the minimum account balance of the suppliers from nations with more than 5 suppliers. Print
-- the nation name, the number of suppliers from that nation, and the minimum account balance.
SELECT n_name, count(*), min(s_acctbal) 
from nation n join supplier s on n_nationkey = s_nationkey
group by s.s_nationkey
having count(*) > 5
