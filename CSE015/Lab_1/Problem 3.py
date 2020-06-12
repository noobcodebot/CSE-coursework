print("Please enter 10 integers: ")

input_string = input("Enter ten integers: ")

list_strings = input_string.split(", ")

list_integers = []
m = 0
for i in range(0, len(list_strings)):
        list_integers.append(int(list_strings[i]))
        if (list_integers[i] > m):
            m = list_integers[i]


print(m)
