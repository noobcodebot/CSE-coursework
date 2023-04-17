-- Find the number of line items that have l shipdate equal to l commitdate
select COUNT(*) from lineitem
where l_commitdate = l_shipdate