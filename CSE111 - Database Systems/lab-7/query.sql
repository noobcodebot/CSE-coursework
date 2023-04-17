SELECT s_name, s_nationkey, w_name
        FROM supplier, nation, warehouse
        WHERE w_suppkey = s_suppkey
        AND w_nationkey = n_nationkey
        AND w_nationkey = 12
        ORDER BY s_name ASC