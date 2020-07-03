import java.util.Scanner;

public class Errors2lab3 {

	public static void main(String[] args) {
		Scanner keyboard = new Scanner(System.in); //keyboard was abbreviated
		float number, theSquare;

		System.out.print("Enter a number and I will "); //Needed a semicolon
		System.out.print("square it for you:  ");//Needed an end quote
		
		number =  keyboard.nextFloat();//Needed ending parentheses and a scanner statement

         theSquare = number * number;

		System.out.print(number + " squared = ");//needed closing parentheses
		System.out.println(theSquare); //literal statement rather than the int
	}
}
