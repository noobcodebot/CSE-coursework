SELECT USrev / ASIArev
FROM (
    SELECT SUM(l_extendedprice * (1 - l_discount)) AS ASIArev
    FROM lineitem, customer, nation, region, orders
    WHERE c_custkey = o_custkey 
        AND o_orderkey = l_orderkey 
        AND c_nationkey = n_nationkey
        AND n_regionkey = r_regionkey 
        AND r_name = 'ASIA' 
        AND strftime('%Y', l_shipdate) = '1997'), (
    SELECT SUM(l_extendedprice * (1 - l_discount)) AS USrev
    FROM lineitem, supplier, nation US, nation ASIA, region, customer, orders
    WHERE c_custkey = o_custkey 
        AND c_nationkey = ASIA.n_nationkey
        AND ASIA.n_regionkey = r_regionkey 
        AND r_name = 'ASIA' 
        AND s_nationkey = US.n_nationkey
        AND US.n_name = 'UNITED STATES' 
        AND s_suppkey = l_suppkey 
        AND l_orderkey = o_orderkey
        AND strftime('%Y', l_shipdate) = '1997')