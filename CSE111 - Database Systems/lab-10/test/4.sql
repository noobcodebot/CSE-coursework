CREATE TRIGGER t4_1 AFTER DELETE ON lineitem
FOR EACH ROW
BEGIN
UPDATE orders SET o_orderpriority = "HIGH" WHERE o_orderkey = OLD.l_orderkey;
END;

CREATE TRIGGER t4_2 AFTER INSERT ON lineitem
FOR EACH ROW
BEGIN
UPDATE orders SET o_orderpriority = "HIGH" WHERE o_orderkey = NEW.l_orderkey;
END;

DELETE
FROM lineitem
WHERE
l_orderkey IN (SELECT l_orderkey FROM lineitem, orders WHERE o_orderdate LIKE '%1995-12%' AND
l_orderkey = o_orderkey);

SELECT COUNT(*)
FROM orders
WHERE
o_orderpriority LIKE '%HIGH%' AND
o_orderdate LIKE '%1995-12%';
DROP TRIGGER t4_1;
DROP TRIGGER t4_2;