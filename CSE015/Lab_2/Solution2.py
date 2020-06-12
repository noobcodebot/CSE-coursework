from logic import TruthTable

prop = input("Enter proposition 1:")
prop2 = input("Enter proposition 2:")

equal = 1

myTable = TruthTable(['p', 'q'], [prop])
myTable.display()

myTable2 = TruthTable(['p', 'q'], [prop2]) 
myTable2.display()

if (myTable.table == myTable2.table):
    equal = 1
else:
    equal = 0

if (equal == 1):
    print("They are equivalent")
else:
    print("They are not equivalent")


