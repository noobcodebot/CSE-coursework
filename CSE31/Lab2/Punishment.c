#include<stdio.h>
#include<stdlib.h>

int main(){
	int size;
	int typo;

	printf("Enter the number of lines for the punishment: ");
	scanf("%d", &size);

	if (size < 0){
		printf("You entered an incorrect number of lines!");
		exit(0);
	}
	else{
		printf("Enter the line for which we want to make a typo: ");
		scanf("%d", &typo);
		if (typo < 0){
			printf("You entered an incorrect value for the number of lines!");
			exit(0);
		}

		for (int i =0; i < size; i++){
			printf("C programming language is the best!\n");

			if(i == typo && typo != 0){

				printf("C programming language is not the best!\n");
			}
		}
	}

}