CREATE TRIGGER t2 AFTER UPDATE ON customer 
WHEN (OLD.c_acctbal < 0 AND NEW.c_acctbal > 0)
BEGIN
UPDATE customer SET c_comment = "Negative balance!!  Add money now!"
WHERE c_acctbal < 0;
END;

UPDATE customer
SET c_acctbal = -100
WHERE 
c_nationkey IN (SELECT n_nationkey FROM nation, region WHERE n_regionkey = r_regionkey AND r_name = 'AMERICA');

SELECT COUNT(*)
FROM customer, nation
WHERE
n_name = 'CANADA' AND
n_nationkey = c_nationkey AND
c_acctbal < 0;
DROP TRIGGER t2;
