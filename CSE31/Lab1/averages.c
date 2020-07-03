#include<stdio.h>


int main(){
int nums=0;
int negnums=0;
int size=1;
int size2=1;
int posav=0;
int negav=0;
int numadd = 0;


	printf("Please enter an integer:" );
		scanf("%d", &numadd);
		if (numadd > 0){
			nums+= numadd;
		}
		else{
			negnums += numadd;
		}
		
		

	while(numadd !=0) {
		printf("Please enter an integer:" );
		scanf("%d", &numadd);
		if (numadd > 0 && numadd != 0){
			nums += numadd;
			size++;
		}
		else if (numadd < 0 && numadd != 0){
			negnums += numadd;
			size2++;
		}
	}
	posav = nums/size;
	negav = negnums/size2;
	if (posav < 0 || posav == 0){
		printf("Negative average: %i\n", negav);
	}
	else{
	printf("Positive average: %i\n", posav);
	printf("Negative average: %i\n", negav);
}
	
}