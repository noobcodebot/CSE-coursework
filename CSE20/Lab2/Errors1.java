import java.util.Scanner; 
public class Errors1 {

	public static void main(String[] args) {
		System.out.println("Can you spot and fix the errors?"); //This line lacked an end quote

		System.out.println("Enter two numbers and I will ");
		System.out.println("add them for you");

		float n1, n2; //switch to float
		Scanner keyboard = new Scanner(System.in); //Missing a semicolon, next float
		n1 = keyboard.nextFloat(); //lacking keyboard in the statement, next float
		n2 = keyboard.nextFloat(); //also lacked keyboard and needs to be altered to Float.
		

		System.out.println("The sum of the numbers is"); //Print statement was incomplete and lacked .out
		System.out.println(n1 + n2); //Needs to be addition
	}
}