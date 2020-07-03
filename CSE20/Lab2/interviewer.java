import java.util.Scanner;
public class interviewer {

	public static void main(String [] args) {
		Scanner input = new Scanner(System.in);
		
		System.out.print("Name of interviewee.");
		String name = input.nextLine();
		System.out.print("What is he wearing?");
		String wearing = input.nextLine();
		System.out.print("What is his favorite music?");
		String music =  input.nextLine();
		System.out.print("What is his major?");
		String major = input.nextLine();
		System.out.print("What is his favorite food?");
		String food = input.nextLine();
		System.out.print("What is his weight?");
		String weight = input.nextLine();
		
		System.out.println("His name is " + name);
		System.out.println("He is wearing " + wearing);
		System.out.println("His favorite music is " + music);
		System.out.println("His major is " + major);
		System.out.println("His favorite food is " + food);
		System.out.println("He weighs " + weight);
	}
}
