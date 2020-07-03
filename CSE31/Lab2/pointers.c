#include <stdio.h>

int main(){
	int x, y, *px, *py;
	int arr[10];

	printf("x:%d\n", x);
	printf("y:%d\n", y);

	// px->x;
	// py->y;
	// printf("%i", px);
	// printf("%i", py);

	int *ptr = &arr[0];
	ptr = arr;
	printf("ptr = arr: %d \n", *ptr);


	// for(int j = 0; j < 10; j++){
	// printf("Arr[%d]: %d \n", j, *ptr++);
	// }
	return 0;
}