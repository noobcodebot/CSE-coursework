from logic import TruthTable

myTable1 = TruthTable(['a'], ['-a'])
myTable1.display();

myTable2 = TruthTable(['a', 'b'], ['a and b'])
myTable2.display();

myTable3 = TruthTable(['a', 'b'], ['a or b'])
myTable3.display();

myTable4 = TruthTable(['a', 'b'], ['a -> b'])
myTable4.display();

myTable5 = TruthTable(['a', 'b'], ['a <-> b'])
myTable5.display();
