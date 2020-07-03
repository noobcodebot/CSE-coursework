
public class FindDuplicate {

	public static void main(String[] args) {
		int[] arr = {1, 2, 2, 3, 4, 2, 4, 3, 0, 5, 3, 2};
		int dupl = 0;

		int i;
		int j;
		for (i=0; i < arr.length; i++) {
			dupl=0;
			for  (j = i + 1 ; j < arr.length; j++) {

				if (arr[i]==arr[j]) 
					dupl++;
			}
			if (dupl==0)
				System.out.println("No duplicates with value " + arr[i] + " beyond Index " + i);
			if(dupl==1)
				System.out.println("There is only " + dupl + " duplicates of value " + arr[i] + " at index " + i);
			if (dupl>1)
				System.out.println("There are " + dupl + " duplicates with value " + arr[i] + " starting at index " + i);
				

				
			}

		}
	}





//collab Sean, Mac,