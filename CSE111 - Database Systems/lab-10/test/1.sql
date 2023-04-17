CREATE TRIGGER t1 AFTER INSERT ON orders
FOR EACH ROW
BEGIN
UPDATE orders SET o_orderdate = '2021-12-01' WHERE o_orderdate='';
END;

INSERT INTO orders
SELECT (o_orderkey), o_custkey, o_orderstatus, o_totalprice, '', o_orderpriority, o_clerk, o_shippriority, o_comment
FROM orders
WHERE
o_orderdate LIKE '%1996-12%';

SELECT count(*)
FROM orders
WHERE
o_orderdate = '2021-12-01';
DROP TRIGGER t1;
