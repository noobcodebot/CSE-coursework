SELECT DISTINCT suppnat94, delta95 - delta94, delta96 - delta95
FROM (
    SELECT suppnat94, (exports94 - imports94) AS delta94
    FROM (
        SELECT nation.n_name AS suppnat94, COUNT(l_quantity) AS exports94
        FROM supplier, customer, lineitem, orders, nation
        WHERE s_suppkey = l_suppkey 
            AND l_orderkey = o_orderkey 
            AND o_custkey = c_custkey
            AND s_nationkey = n_nationkey
            AND c_nationkey != n_nationkey
            AND STRFTIME('%Y', l_shipdate) = '1994'
        GROUP BY suppnat94),
        (
        SELECT nation.n_name AS custnat, COUNT(l_quantity) AS imports94
        FROM supplier, customer, lineitem, orders, nation
        WHERE s_suppkey = l_suppkey 
            AND l_orderkey = o_orderkey 
            AND o_custkey = c_custkey
            AND c_nationkey = n_nationkey
            AND s_nationkey != n_nationkey
            AND STRFTIME('%Y', l_shipdate) = '1994'
        GROUP BY custnat)
    WHERE suppnat94 = custnat) AS res94,
    (
    SELECT suppnat95, (exports95 - imports95) AS delta95
    FROM (
        SELECT nation.n_name AS suppnat95, COUNT(l_quantity) AS exports95
        FROM supplier, customer, lineitem, orders, nation
        WHERE s_suppkey = l_suppkey 
            AND l_orderkey = o_orderkey 
            AND o_custkey = c_custkey
            AND s_nationkey = n_nationkey
            AND c_nationkey != n_nationkey
            AND STRFTIME('%Y', l_shipdate) = '1995'
        GROUP BY suppnat95),
        (
        SELECT nation.n_name AS custnat, COUNT(l_quantity) AS imports95
        FROM supplier, customer, lineitem, orders, nation
        WHERE s_suppkey = l_suppkey 
            AND l_orderkey = o_orderkey 
            AND o_custkey = c_custkey
            AND c_nationkey = n_nationkey
            AND s_nationkey != n_nationkey
            AND STRFTIME('%Y', l_shipdate) = '1995'
        GROUP BY custnat)
    WHERE suppnat95 = custnat) AS res95,
    (
    SELECT suppnat96, (exports96 - imports96) AS delta96
    FROM (
        SELECT nation.n_name AS suppnat96, COUNT(l_quantity) AS exports96
        FROM supplier, customer, lineitem, orders, nation
        WHERE s_suppkey = l_suppkey 
            AND l_orderkey = o_orderkey 
            AND o_custkey = c_custkey
            AND s_nationkey = n_nationkey
            AND c_nationkey != n_nationkey
            AND STRFTIME('%Y', l_shipdate) = '1996'
        GROUP BY suppnat96),
        (
        SELECT nation.n_name AS custnat, COUNT(l_quantity) AS imports96
        FROM supplier, customer, lineitem, orders, nation
        WHERE s_suppkey = l_suppkey 
            AND l_orderkey = o_orderkey 
            AND o_custkey = c_custkey
            AND c_nationkey = n_nationkey
            AND s_nationkey != n_nationkey
            AND STRFTIME('%Y', l_shipdate) = '1996'
        GROUP BY custnat)
    WHERE suppnat96 = custnat) AS res96
WHERE res94.suppnat94 = res95.suppnat95
    AND res95.suppnat95 = res96.suppnat96