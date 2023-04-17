import sqlite3
from sqlite3 import Error


def openConnection(_dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Open database: ", _dbFile)

    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

    return conn

def closeConnection(_conn, _dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Close database: ", _dbFile)

    try:
        _conn.close()
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

def drop_view(_conn, view):
    c = _conn.cursor()
    c.execute(f'DROP VIEW {view}')

def create_View1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V1")
    c = _conn.cursor()
    c.execute(
        '''
        CREATE VIEW V1(c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, c_nation, c_region)
        AS
        SELECT c.c_custkey, c.c_name, c.c_address, c.c_phone, c.c_acctbal, c.c_mktsegment, c.c_comment, n.n_name, r.r_name 
        FROM Customer c 
        JOIN Nation n
        ON c.c_nationkey = n.n_nationkey
        JOIN region r
        ON n.n_regionkey = r.r_regionkey
        '''
    )
    print("++++++++++++++++++++++++++++++++++")


def create_View2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V2")
    c = _conn.cursor()
    c.execute(
        '''
        CREATE VIEW V2(s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, s_nation, s_region)
        AS
        SELECT s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n_name, r_name
        FROM supplier s 
        JOIN nation n 
        ON s.s_nationkey = n.n_nationkey
        JOIN region r 
        ON n.n_regionkey = r.r_regionkey
        '''
    )
    print("++++++++++++++++++++++++++++++++++")


def create_View5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V5")
    c = _conn.cursor()
    c.execute('''
    Create VIEW V5(o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderyear, o_orderpriority, o_clerk,
    o_shippriority, o_comment) AS
    SELECT o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk,
    o_shippriority, o_comment from orders
    ''')
    print("++++++++++++++++++++++++++++++++++")


def create_View10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create VIEW V10")
    c = _conn.cursor()
    c.execute('''
    Create VIEW V10(p_type, min_discount, max_discount) AS
    SELECT p.p_type, MIN(l.l_discount), MAX(l.l_discount)
    FROM Part p JOIN Lineitem l 
    ON p.p_partkey = l.l_partkey
    GROUP BY p.p_type
    ''')
    print("++++++++++++++++++++++++++++++++++")


def create_View151(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create VIEW V151")
    c = _conn.cursor()
    c.execute(
        '''
        CREATE VIEW V151(c_custkey, c_name, c_nationkey, c_acctbal)
        AS
        SELECT c_custkey, c_name, c_nationkey, c_acctbal
        FROM customer
        WHERE c_acctbal > 0
    ''')
    print("++++++++++++++++++++++++++++++++++")


def create_View152(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V152")
    c = _conn.cursor()
    c.execute(
        '''
        CREATE VIEW V152(s_suppkey, s_name, s_nationkey, s_acctbal)
        AS
        SELECT s_suppkey, s_name, s_nationkey, s_acctbal
        FROM supplier
        WHERE s_acctbal < 0
        '''
        )
    print("++++++++++++++++++++++++++++++++++")

# TODO - Add code to write tuples to output/1.out in right format
def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")
    c = _conn.cursor()
    c.execute(
        '''
        SELECT c_name, sum(o_totalprice) FROM 
        (SELECT * FROM V1, orders
        WHERE c_custkey = o_custkey
        AND c_nation = 'FRANCE'
        AND o_orderdate like '1995-__-__'
        GROUP BY o_orderdate)
        GROUP BY c_name
        '''
    )
    res = c.fetchall()
    with open('output/1.out', 'w+') as file:
        for record in res:
            s = str(record[1])
            decimal = s.split('.')
            if(len(decimal[1]) > 2):
                r = round(record[1], 2)
                file.write(f"{record[0]}|{r}\n")
            else:
                file.write(f"{record[0]}|{record[1]}\n")

    # drop_view(_conn, "V1")
    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")
    c = _conn.cursor()
    c.execute(
        '''
        SELECT s_region, count(*) FROM V2
        GROUP BY s_region
        '''
    )
    res = c.fetchall()
    with open("output/2.out", 'w+') as file:
        for record in res:
            file.write(f"{record[0]}|{record[1]}\n")

    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")
    c = _conn.cursor()
    c.execute(
        '''
        select c_nation, count(*) FROM
        (SELECT * FROM V1, orders
        WHERE c_custkey = o_custkey
            AND c_region = 'AMERICA')
        GROUP BY c_nation
        '''
    )
    res = c.fetchall()
    with open("output/3.out", 'w+') as file:
        for record in res:
            file.write(f"{record[0]}|{record[1]}\n")
    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")
    c = _conn.cursor()
    c.execute(
        '''
        SELECT s_name, count(ps_partkey) FROM V2, partsupp, part
        WHERE p_partkey = ps_partkey
            and ps_suppkey = s_suppkey
            and s_nation = 'CANADA'
            and p_size <20
        GROUP BY s_name
        '''
    )
    res = c.fetchall()
    with open("output/4.out", 'w+') as file:
        for record in res:
            file.write(f"{record[0]}|{record[1]}\n")
    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")
    c = _conn.cursor()
    c.execute(
        '''
        SELECT c_name, count(*)
        FROM V1, V5
        WHERE c_custkey = o_custkey
            AND c_nation = 'GERMANY'
            AND o_orderyear like '1993-__-__'
        GROUP BY c_name
        '''
    )
    res = c.fetchall()
    with open("output/5.out", 'w+') as file:
        for record in res:
            file.write(f"{record[0]}|{record[1]}\n")
    print("++++++++++++++++++++++++++++++++++")


def Q6(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q6")
    c = _conn.cursor()
    c.execute(
        '''
        SELECT s_name, o_orderpriority, count(distinct ps_partkey)
        FROM V2, V5, partsupp, lineitem
        WHERE l_orderkey = o_orderkey
            and l_partkey = ps_partkey
            and l_suppkey = ps_suppkey
            and ps_suppkey = s_suppkey
            and s_nation = 'CANADA'
        GROUP BY s_name, o_orderpriority
        '''
    )
    res = c.fetchall()
    with open("output/6.out", 'w+') as file:
        for record in res:
            file.write(f"{record[0]}|{record[1]}|{record[2]}\n")
    print("++++++++++++++++++++++++++++++++++")


def Q7(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q7")
    c = _conn.cursor()
    c.execute(
        '''
        SELECT c_nation, o_orderstatus, count(*)
        FROM V1, V5
        WHERE o_custkey = c_custkey
            AND c_region = 'AMERICA'
        group by c_nation, o_orderstatus;
        '''
    )
    res = c.fetchall()
    with open("output/7.out", 'w+') as file:
        for record in res:
            file.write(f"{record[0]}|{record[1]}|{record[2]}\n")
    print("++++++++++++++++++++++++++++++++++")


def Q8(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q8")
    c = _conn.cursor()
    c.execute(
        '''
        SELECT s_nation, count(distinct l_orderkey) as co 
        FROM V2, V5, lineitem
        where o_orderkey = l_orderkey
            and l_suppkey = s_suppkey
        and o_orderstatus = 'F'
            and o_orderyear like '1995-__-__'
        group by s_nation
        having co > 50;
        '''
    )
    res = c.fetchall()
    with open("output/8.out", 'w+') as file:
        for record in res:
            file.write(f"{record[0]}|{record[1]}\n")
    print("++++++++++++++++++++++++++++++++++")


def Q9(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q9")
    c = _conn.cursor()
    c.execute(
        '''
        SELECT count(distinct o_clerk)
        FROM V2, V5, lineitem
        WHERE o_orderkey = l_orderkey
            AND l_suppkey = s_suppkey
            AND s_nation = 'UNITED STATES'
        '''
    )
    res = c.fetchall()
    with open("output/9.out", 'w+') as file:
        for record in res:
            file.write(f"{record[0]}\n")
    print("++++++++++++++++++++++++++++++++++")


def Q10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q10")
    c = _conn.cursor()
    c.execute(
        '''
    SELECT p_type, min_discount, max_discount
    FROM V10
    WHERE p_type like "%ECONOMY%"
        AND p_type like '%COPPER%'
    GROUP BY p_type
        '''
    )
    res = c.fetchall()
    with open("output/10.out", 'w+') as file:
        for record in res:
            file.write(f"{record[0]}|{record[1]}|{record[2]}\n")
    print("++++++++++++++++++++++++++++++++++")


def Q11(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q11")
    c = _conn.cursor()
    c.execute(
        '''
    SELECT s.s_region, s.s_name, s.s_acctbal
    FROM V2 s
    WHERE s_acctbal = (SELECT max(s1.s_acctbal)
                        from supplier s1, nation n1, region r1
                                where s1.s_nationkey = n1.n_nationkey
                                    and n1.n_regionkey = r1.r_regionkey
                                    and s_region = r1.r_name)
        '''
    )
    res = c.fetchall()
    with open("output/11.out", 'w+') as file:
        for record in res:
            file.write(f"{record[0]}|{record[1]}|{record[2]}\n")
    print("++++++++++++++++++++++++++++++++++")


def Q12(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q12")
    c = _conn.cursor()
    c.execute(
        '''
        SELECT s_nation, max(s_acctbal) as mb 
        FROM V2
        GROUP BY s_nation
        having mb > 9000;
        '''
    )
    res = c.fetchall()
    with open("output/12.out", 'w+') as file:
        for record in res:
            file.write(f"{record[0]}|{record[1]}\n")
    print("++++++++++++++++++++++++++++++++++")


def Q13(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q13")
    c = _conn.cursor()
    c.execute(
        '''
        SELECT COUNT(*)
        FROM V1, V2, lineitem, nation n1, nation n2, region r, orders
        where o_orderkey = l_orderkey
        and o_custkey = c_custkey
            and l_suppkey = s_suppkey
            and s_nation = n1.n_name
            and n1.n_regionkey = r_regionkey
            and c_nation = n2.n_name
            and r_name = 'AFRICA'
            and n2.n_name = 'UNITED STATES';
        '''
    )
    res = c.fetchall()
    with open("output/13.out", 'w+') as file:
        for record in res:
            file.write(f"{record[0]}\n")
    print("++++++++++++++++++++++++++++++++++")


def Q14(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q14")
    c = _conn.cursor()
    c.execute(
        '''
        SELECT s_region as suppRegion, c_region as custRegion, max(o_totalprice)
        FROM V1, V2, orders, lineitem
        WHERE l_suppkey = s_suppkey
            and l_orderkey = o_orderkey
            and o_custkey = c_custkey
        group by s_region, c_region;
        '''
    )
    res = c.fetchall()
    with open("output/14.out", 'w+') as file:
        for record in res:
            file.write(f"{record[0]}|{record[1]}|{record[2]}\n")
    print("++++++++++++++++++++++++++++++++++")


def Q15(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q15")
    c = _conn.cursor()
    c.execute(
        '''
        SELECT count(DISTINCT l_orderkey)
        FROM lineitem, V151, V152, orders
        where l_suppkey = s_suppkey
            and l_orderkey = o_orderkey
            and o_custkey = c_custkey
            and c_acctbal > 0
            and s_acctbal < 0;
        '''
    )
    res = c.fetchall()
    with open("output/15.out", 'w+') as file:
        for record in res:
            file.write(f"{record[0]}\n")
    print("++++++++++++++++++++++++++++++++++")

def drop_view(_conn, view):
    c = _conn.cursor()
    c.execute(
        f'''
        DROP VIEW IF EXISTS {view}
        '''
    )


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    drop_view(conn, "V1")
    drop_view(conn, "V2")
    drop_view(conn, "V5")
    drop_view(conn, "V10")
    drop_view(conn, "V151")
    drop_view(conn, "V152")
    with conn:
        create_View1(conn)
        Q1(conn)
        create_View2(conn)
        Q2(conn)

        Q3(conn)
        Q4(conn)

        create_View5(conn)
        Q5(conn)

        Q6(conn)
        Q7(conn)
        Q8(conn)
        Q9(conn)

        create_View10(conn)
        Q10(conn)

        Q11(conn)
        Q12(conn)
        Q13(conn)
        Q14(conn)

        create_View151(conn)
        create_View152(conn)
        Q15(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
