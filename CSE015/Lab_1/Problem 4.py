

input_string = input("Enter ten integers: ")

list_strings = input_string.split(", ")

list_integers = []
m = 0
for i in range(0, len(list_strings)):
        list_integers.append(int(list_strings[i]))
        if (list_integers[i] > m and list_integers[i] % 2 != 0):
            m= list_integers[i]
            #restricted loop to only scroll through negative numbers
            #m only adopts i's value if i is larger than current m value
if (m % 2 != 0):
    print(m)
else:
    print("No odd numbers were entered.")
