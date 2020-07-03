import java.util.Scanner;
public class lab_01 {
	public static void main(String[] args) {
		Scanner input = new Scanner(System.in);

		int result = 0;
		System.out.println("Please enter the max number: ");
		int max = input.nextInt();
		while (max < 0) {
			System.out.println("Invalid input. Please enter a valid divisor. ( >0)");
			max = input.nextInt();
		}
		System.out.println("Please enter the divisor: ");
		int div = input.nextInt();
		while (div < 0) {
			System.out.println("Invalid input. Please enter a valid divisor. ( >0)");
			div = input.nextInt();
		}
		if (max <= div) {
			System.out.println("No numbers were found.");
		}
		else
		{
			System.out.println("Multiples of " + div + " between 1 and "  + max + "(inclusive) are :" );
			for (int i=1; i*div <= max; i++) {
				if (max % div == 0) 
					result = i * div;

				System.out.println(result);
			}

		}




	}
}