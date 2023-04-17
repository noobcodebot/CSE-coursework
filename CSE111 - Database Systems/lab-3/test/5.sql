-- What is the total account balance among the customers in every market segment?
SELECT c_mktsegment, sum(c_acctbal) from customer
group by c_mktsegment