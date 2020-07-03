import java.util.Scanner;

public class Errors3 { //needed brace

	public static void main(String[] args) {
		Scanner keyboard = new Scanner(System.in); //Had bad syntax
		int numerator; //Case issue in int
		int denominator; //int is not spelled out

		System.out.println("This program divides two numbers."); //lacking proper print statement
		System.out.print("Enter the numerator: ");
		numerator = keyboard.nextInt();
		System.out.print("Enter the denominator: ");
		denominator = keyboard.nextInt(); //keyboard spelled wrong and denominator

		System.out.print(numerator); //Case issue in statement
		System.out.print("/");
		System.out.print(denominator); //Case issue in statement
		System.out.print(" = ");
		System.out.println((double) numerator/denominator);
	}
}//needed the brace
