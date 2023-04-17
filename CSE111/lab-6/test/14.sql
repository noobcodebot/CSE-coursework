SELECT suppnat, (exports - imports)
FROM (
    SELECT supp.n_name AS suppnat, COUNT(l_quantity) AS exports
    FROM supplier, customer, lineitem, orders, nation supp, nation cust
    WHERE s_suppkey = l_suppkey 
        AND l_orderkey = o_orderkey 
        AND o_custkey = c_custkey
        AND c_nationkey = cust.n_nationkey
        AND s_nationkey = supp.n_nationkey
        AND cust.n_nationkey != supp.n_nationkey
        AND STRFTIME('%Y', l_shipdate) = '1994'
    GROUP BY suppnat),
    (
    SELECT cust.n_name AS custnat, COUNT(l_quantity) AS imports
    FROM supplier, customer, lineitem, orders, nation supp, nation cust
    WHERE s_suppkey = l_suppkey 
        AND l_orderkey = o_orderkey 
        AND o_custkey = c_custkey
        AND c_nationkey = cust.n_nationkey
        AND s_nationkey = supp.n_nationkey
        AND cust.n_nationkey != supp.n_nationkey
        AND STRFTIME('%Y', l_shipdate) = '1994'
    GROUP BY custnat)
WHERE suppnat = custnat