#include <stdio.h>

/*
    Read a set of values from the user.
    Store the sum in the sum variable and return the number of values read.
*/
double read_values(double avg) {
  double values=0;
  float input=0;
  int sum = 0;
  avg = 0;
  printf("Enter input values (enter 0 to finish):\n");
  scanf("%g",&input);
  while(input != 0) {
    values++;
    sum += input;
    scanf("%g",&input);
  }
  avg = sum/values;
  return avg;
}


int main() {
double avg = read_values(avg);
  //int values = 0 ;
  printf("Average: %g\n", avg);
  return 0;
}

