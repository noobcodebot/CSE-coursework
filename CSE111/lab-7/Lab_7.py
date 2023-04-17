from itertools import count
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


def createTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create table")
    _conn.execute('''
    CREATE TABLE warehouse
    (w_warehousekey decimal(9,0) not null,
    w_name char(100) not null,
    w_capacity decimal(6,0) not null,
    w_suppkey decimal(9,0) not null,
    w_nationkey decimal(2,0) not null)''')
    print("++++++++++++++++++++++++++++++++++")


def dropTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Drop tables")
    _conn.execute("DROP TABLE warehouse")
    print("++++++++++++++++++++++++++++++++++")


def populateTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Populate table")
    c = _conn.cursor()
    # Query for all suppliers
    c.execute('''
    SELECT s_name FROM Supplier
    ''')
    s_res = c.fetchall()
    supps = []
    # Turn tuple results into a list
    for i in range(len(s_res)):
        supps.append(s_res[i][0])

    # Poplate dictionary with the two nations per supplier    
    tabledict = {}
    for s in supps:
        c.execute(f'''
        SELECT n.n_name, n.n_nationkey FROM Nation n JOIN Customer c 
        on c.c_nationkey = n.n_nationkey
        JOIN Orders o on o.o_custkey = c.c_custkey
        JOIN Lineitem l on l.l_orderkey = o.o_orderkey
        JOIN Supplier s on s.s_suppkey = l.l_suppkey
        WHERE s_name = "{s}"
        GROUP BY n.n_name
        ORDER BY COUNT(l_linenumber)
        DESC LIMIT 2;
        ''')
        tabledict[s] = c.fetchall()
        # print(tabledict[s])
    w_names = []
    # Construct Warehouse names from values in dictionary
    for s in supps:
        for i in range(0,2):
            ## access string inside of tuple using tabledict[s][0][0]
            warehouseName1 = s + '___' + tabledict[s][i][0]
            w_names.append(warehouseName1)

    capacity = {}
    for s in supps:
        c.execute(f'''
            SELECT MAX(CAP) FROM (
            SELECT n_name, SUM(p_size) * 2 AS CAP
            FROM lineitem, customer, orders, supplier, part, nation
            WHERE o_orderkey = l_orderkey
            AND c_custkey = o_custkey
            AND s_suppkey = l_suppkey
            AND c_nationkey = n_nationkey
            AND p_partkey = l_partkey 
            AND s_name = '{s}'
            GROUP BY n_name
            )''')
        capacity[s] = c.fetchall()
    capacities = {}
    for s in supps:
        capacities[s] = capacity[s][0][0]
    j = 0
    w_id = 1
    supp_id = 1
    k = 0 
    for s in supps:
        for i in range(0, 2):
            c.execute(f'''
            INSERT INTO Warehouse(w_warehousekey, w_name, w_capacity, w_suppkey, w_nationkey)
            VALUES({w_id}, '{w_names[j]}', {capacities[s]}, {supp_id}, {tabledict[s][i][1]})
            ''')
            w_id += 1
            j += 1
        supp_id +=1
    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")
    c = _conn.cursor()
    c.execute('''
        SELECT w_warehousekey AS wId, w_name AS wName, w_capacity AS wCap, w_suppkey AS sId, w_nationkey AS nId 
                 FROM warehouse
                 GROUP BY w_warehousekey
    ''')
    f = open("output/1.out", "w")
    res = []
    res = c.fetchall()
    f.write(f"{'wId' : >10} {'wName' :41}{'wCap' : >10} {'sId' : >10} {'nId' :>10}")
    for i in range(0, len(res)):
        f.write(f"\n{res[i][0]:>10} {res[i][1] :41}{res[i][2]:10} {res[i][3]:10} {res[i][4]:10}")
    f.close()
    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")
    c = _conn.cursor()
    c.execute('''
    SELECT n_name, COUNT(w_nationkey), SUM(w_capacity) FROM
    warehouse w, nation n
    WHERE w.w_nationkey = n.n_nationkey
    AND w.w_nationkey = n.n_nationkey
    GROUP BY w_nationkey
    ORDER BY COUNT(w_nationkey) DESC, w_capacity DESC, n_name ASC;
    ''')
    res = c.fetchall()
    f = open('output/2.out', 'w')
    f.write(f"{'nation ':10}{'numW' :>41} {'totCap' : >10}")
    for i in range(len(res)):
        f.write(f"\n{res[i][0]:30}{res[i][1] :>21} {res[i][2] :>10}")
    f.close()
    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")
    with open('input/3.in') as f:
        nation = f.read().replace('\n', '')
    c = _conn.cursor()
    c.execute('''
    Select * from nation
    ''')
    allNats = c.fetchall()
    c.execute(
        f'''
        SELECT n_nationkey FROM nation
        WHERE n_name = '{nation}'
        '''
    )
    res = c.fetchall()
    nId = res[0][0]
    c.execute(
        f'''
        SELECT s_name, s_nationkey, w_name
        FROM supplier, nation, warehouse
        WHERE w_suppkey = s_suppkey
        AND w_nationkey = n_nationkey
        AND w_nationkey = '{nId}'
        ORDER BY s_name ASC
        ''')
    res = c.fetchall()
    dict = {}
    for i in range (len(res)):
        for j in range(len(allNats)):
            if(res[i][1] == allNats[j][0]):
                dict[res[i][1]] = allNats[j][1]
    f = open('output/3.out', 'w')
    f.write(f"{'supplier':13} {'nation' :>13}   {'warehouse' :>21}")
    for i in range(0,len(res)):
        f.write(f"\n{res[i][0]:10}{dict[res[i][1]] :^12}{res[i][2] :>38}")
    f.close()
    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")
    inputs = []
    f = open("input/4.in", 'r+')
    for line in f:
        inputs.append(line.replace('\n', ""))
    f.close()
    c = _conn.cursor()
    c.execute(
        f'''
        SELECT w_name, w_capacity
        FROM warehouse, region, nation
        WHERE w_nationkey = n_nationkey
        AND n_regionkey = r_regionkey
        AND r_name = '{inputs[0]}'
        AND w_capacity > {inputs[1]}
        GROUP BY w_warehousekey
        ORDER BY w_capacity DESC
        '''
    )
    res = c.fetchall()
    f = open('output/4.out', 'w')
    f.write(f"{'warehouse':35} {'capacity' :>15}")
    for i in range(0, len(res)):
        f.write(f"\n{res[i][0]:35} {res[i][1]:>15}")


    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")
    with open('input/5.in') as f:
        nation = f.read().replace('\n', '')
    c = _conn.cursor()
    c.execute(
        f'''
        SELECT n_nationkey from nation where n_name ='{nation}'
        ''')
    nId = c.fetchall()
    c.execute(
        f'''
        SELECT s_name from supplier, nation
        WHERE s_nationkey = n_nationkey
        AND n_name = '{nation}'
        '''
        )
    supps = []
    supps += c.fetchall()
    regions = ['AFRICA', 'AMERICA', 'ASIA', 'EUROPE', 'MIDDLE EAST']
    regionTable = {'AFRICA':0, 'AMERICA':0, 'ASIA':0, 'EUROPE':0, 'MIDDLE EAST':0}
    for s in supps:
        j = 0
        for i in range(0, len(regions)):
            c.execute(
            f'''
            select sum(w_capacity) from warehouse, nation, region, supplier
            where w_nationkey = n_nationkey
            and n_regionkey = r_regionkey
            and s_suppkey = w_suppkey
            and r_name = '{regions[i]}' and s_nationkey = {nId[0][0]};
            '''
            )
            res = c.fetchall()
            if (res[0][0] is None):
                cap = 0
            else:
                cap = res[0][0]
            print(res)
            if(len(res) > 0):
                regionTable[regions[i]] = cap
    print(regionTable)
    f = open('output/5.out', 'w')
    f.write(f"{'region':28} {'capacity':>12}")
    for region in regionTable:
        f.write(f"\n{region:28} {regionTable[region]:>12}")
    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        dropTable(conn)
        createTable(conn)
        populateTable(conn)

        Q1(conn)
        Q2(conn)
        Q3(conn)
        Q4(conn)
        Q5(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
