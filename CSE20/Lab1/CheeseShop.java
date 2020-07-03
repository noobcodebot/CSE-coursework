import java.util.Scanner;
public class CheeseShop {
	public static void main(String[] args){
		double price = 0;
		double discount1 = 0;
		double discount2 = 0;
		double discount3 = 0;
		double hum = 25.0;
		double red = 40.5;
		double tel = 17.25;
		
		String humb = "Humbolt Fog";
		String redh = "Red Hawk";
		String tele = "Teleme";
		Scanner input = new Scanner(System.in);

		System.out.println("Please choose from our variety of 3 cheeses: ");
		System.out.println("Humboldt Fog at $25.00/lb");
		System.out.println("Red Hawk at $40.50/lb");
		System.out.println("Teleme at $17.25/lb");
		System.out.println("Please enter how many pounds you'd like per cheese: ");

		System.out.println(humb + ": ");

		double lbsh = input.nextDouble();
		while (lbsh % 0.5 != 0 || lbsh < 0 ) {
			System.out.println("Invalid input. Enter a value that's a multiple of 0.5: and >0");
			lbsh = input.nextDouble();
		}

		System.out.println(redh + ": ");

		double lbsr = input.nextDouble();
		while (lbsr % 0.5 != 0 || lbsr < 0 ) {
			System.out.println("Invalid input. Enter a value that's a multiple of 0.5 and >0:");
			lbsr = input.nextDouble();
		}

		System.out.println(tele + ": ");

		double lbst = input.nextDouble();
		while (lbst % 0.5 != 0 || lbst < 0 ) {
			System.out.println("Invalid input. Enter a value that's a multiple of 0.5 and >0:");
			lbst = input.nextDouble();
		}

		double tot1 = hum * lbsh;
		double tot2 = red * lbsr;
		double tot3 = tel * lbst;
		
		price = (tot1+tot2+tot3);
		if (lbsh >= 0.5 ) 
			discount1 = (int)lbsh * hum;
		lbsh = lbsh * 2;
		if (lbsr >= 1)
			discount2 = ((int)lbsr * 0.5) * red;
		lbsr = lbsr +((int)lbsr * 0.5);
		System.out.println("Display the itemzed list? 1 for yes");
		int choice = input.nextInt();
		
		if (choice == 1 && tot1 > 0 && tot2 > 0 && tot3 >= 0) {
			System.out.println(lbsh + "lb of " + humb + " @ $" + hum + " = " + " $"+hum * lbsh ); 
			System.out.println(lbsr + "lb of " + redh + " @ $" + red + " = " + " $" + red * lbsr); 
			System.out.println(lbst + "lb of " + tele + " @ $" + tel + " = " + " $" + tel * lbst );
			System.out.println();
			System.out.println("Sub total: $" + ( (25.0 * lbsh) + (40.5 * lbsr) + (17.25 * lbst))  );
			System.out.println("Discounts: ");
			System.out.println("Humboldt (buy one get one free): -$" + discount1);
			System.out.println("Red Hawk (Buy two get one free): -$" + discount2);
			System.out.print("Total: $"+ price);
		}
		else if (choice != 1 && tot1 > 0 && tot2 > 0 && tot3 >= 0) {
			System.out.println();
			System.out.println("Sub total: $" + price);
			System.out.println("Discounts: -$" + (discount1+discount2+discount3));
			System.out.println("Total: " + (price - (discount1+discount2+discount3)) );
		}
		else if (choice == 1 && tot1 == 0 && tot2 == 0 && tot3 ==0) {
			int total = 0;
			System.out.println("No items were purchased.");
			System.out.println();
			System.out.println("Sub total:  " +  total );
			System.out.println("Discounts... \n" + "none");}
			else {
				System.out.println("Sub total: $" + ( (25.0 * lbsh) + (40.5 * lbsr) + (17.25 * lbst))  );
				System.out.println("Discounts: ");
				System.out.println("Humboldt (buy one get one free): -$" + discount1);
				System.out.println("Red Hawk (Buy two get one free): -$" + discount2);
				System.out.print("Total: $"+ price);}
			
		

	}	
}