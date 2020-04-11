import java.util.*;
public class lab0 {
	public static void main(String[] args)
	{
		int size;
		System.out.println("Welcome to the array calculator program!");
		do
		{
			System.out.println("Enter the size of the array(-1 to quit):");
		Scanner num= new Scanner(System.in);
		size= num.nextInt();
		if (size != -1)
		{
		int[]sizeA= new int[size];
		System.out.println("Please enter " + size + " integer(s):");
		for (int i=0; i<size; i++)
		{
			sizeA[i]= num.nextInt();
		}
		System.out.println("Multiply or add?");
		String operator= num.next();
		if (operator.equals("*"))
		{
			int product=1;
			for (int i=0; i<size; i++)
			{
				product = product*sizeA[i];
			}
			System.out.println("The product of the array values is: " + product);
		}
		if (operator.equals("+"))
		{
			int sum=0;
			for (int i=0; i<size; i++)
			{
				sum = sum+sizeA[i];
			}
			System.out.println("The sum of the array values is: " + sum);
		}
		}
		}while (size != -1);
				
				System.out.print("Goodbye!");
	}

}
