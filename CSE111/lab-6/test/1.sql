-- Find the total quantity (l quantity) of line items shipped per month (l shipdate) in 1995. Hint:
-- check function strftime to extract the month/year from a date.
SELECT strftime("%m", l_shipdate) AS month, SUM(l_quantity)
FROM lineitem
WHERE strftime("%Y", l_shipdate) = '1995'
GROUP BY month;