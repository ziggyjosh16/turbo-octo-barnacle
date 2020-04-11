/*
Name: Joshua Sharkey
Discussion: 805
 */
import java.util.*;
public class Program01 {

	public static void main(String[] args) {
		System.out.println("Welcome to the birthday problem Simulator\n");
		String userAnswer="";
		Scanner stdIn = new Scanner(System.in);
		do {
			int [] userInput = promptAndRead(stdIn);
			double probability = compute(userInput[0], userInput[1]);

			// Print results
			System.out.println("For a group of " + userInput[1] + " people, the probability");
			System.out.print("that two people have the same birthday is\n");
			System.out.println(probability);

			System.out.print("\nDo you want to run another set of simulations(y/n)? :");

			//eat or skip empty line
			stdIn.nextLine();
			userAnswer = stdIn.nextLine();


		} while (userAnswer.equals("y"));

		System.out.println("Goodbye!");
		stdIn.close();
	}
	// Prompt user to provide the number of simulations and number of people and return them as an array
	public static int[] promptAndRead(Scanner stdIn) {
		// TODO
		int simulations;
		do{
		System.out.print("Please Enter the number of simulations to do: ");
			simulations= stdIn.nextInt(); 
		} while (simulations <= 0);
		
		int size;
		do{
		System.out.print("Please Enter the size of the group of people: ");
		 size= stdIn.nextInt();
		} while (size < 2 || size > 365);
		 
		int [] parameters = new int [2];
		 parameters [0]=simulations;
		 parameters [1]=size;
		 return parameters;	
	}
	// This is the method that actually does the calculations.
	public static double compute(int numOfSimulation, int numOfPeople) {
		// TODO
			double denom= numOfSimulation;
			int [] people= new int [numOfPeople]; 
			double twins=0.0;
			Random rnd = new Random(1);
			do
			{
				//fill array with random birthdays
				for (int i=0; i<numOfPeople-1; i++)
				{
				people [i] = rnd.nextInt(364);
				}
				//check array for duplicates
				for (int j=0; j<numOfPeople-1; j++)
				{
					for (int k=j+1; k<numOfPeople-1; k++)
					{
						if (people[j]==people[k])
						{
							//if there is a match record it and begin the next simulation
							j=numOfPeople-1;
							twins ++;
						}
					}
				}			
			numOfSimulation --;
			}
			while (numOfSimulation > 0);
			
			System.out.println(twins);
			System.out.println(denom);
			 double computation = twins/denom;
			 return computation;
				
		
	}
}

