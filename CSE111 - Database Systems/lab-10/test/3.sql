CREATE TRIGGER t3 AFTER UPDATE ON customer 
WHEN (OLD.c_acctbal < 0 AND NEW.c_acctbal > 0)
BEGIN
UPDATE customer SET c_comment = "Positive balance!!  Add money now!"
WHERE c_acctbal > 0;
END;

UPDATE customer
SET c_acctbal = 100
WHERE 
c_nationkey IN (SELECT n_nationkey FROM nation, region WHERE n_regionkey = r_regionkey AND n_name = 'UNITED STATES');

SELECT COUNT(*)
FROM customer, nation, region
WHERE
r_name = 'AMERICA' AND
n_nationkey = c_nationkey AND
n_regionkey = r_regionkey AND 
c_acctbal < 0;
DROP TRIGGER t3;
