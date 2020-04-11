import java.util.*;

public class RouletteTestDriver {
	public static void main(String[] args) {
		Scanner gooby = new Scanner(System.in);
		System.out.println("Welcome to the Roulette Simulator!!!");
		System.out.println("Enter number of roulette tests to run: ");
		int numTests = gooby.nextInt();
		System.out.println("Enter number of spins: ");
		int numSpins = gooby.nextInt();
		ArrayList<RouletteTest> games = new ArrayList<RouletteTest>();
		for (int i = 0; i <= numTests - 1; i++) {
			games.add(i, new RouletteTest(numSpins));
		}
		sortRouletteTests(games);
		System.out.println();
		System.out.println("Least Variable Test: ");
		System.out.println();
		printTestSummary(games.get(numTests - 1));
		System.out.println();

		System.out.println("[" +games.get(numTests - 1).toString()+ "]");
		System.out.println();
		System.out.println("-----------------------------");
		System.out.println("Most Variable Test: ");
		System.out.println();
		printTestSummary(games.get(0));
		System.out.println();
		System.out.println("[" +games.get(0).toString()+ "]");
		System.out.println();
		System.out.println("-----------------------------");
		System.out.println("Sorted Summary of All Tests");
		System.out.println();
		
		for (int imTiredOfUsingI = 0; imTiredOfUsingI < games.size(); imTiredOfUsingI++) {
			printTestSummary(games.get(imTiredOfUsingI));
		}

		System.out.println("Goodbye!");
	}

	private static void sortRouletteTests(ArrayList<RouletteTest> rTests) {
		RouletteTest temp;
		for (int k = 0; k < rTests.size() - 1; k++) {
			if (rTests.get(k).getStdDev() > rTests.get(k + 1).getStdDev()) {
				temp = rTests.get(k);
				rTests.set(k, rTests.get(k + 1));
				rTests.set(k + 1, temp);
			}
		}
	}

	private static void printTestSummary(RouletteTest rt) {
		System.out.println( "StdDev: " + rt.getStdDev() + ", Hottest: " + rt.getHottestPocket()+ " (" +rt.getPocketCount(rt.getHottestPocket()) + ")," + "Coldest: " 
				+ rt.getColdestPocket() + " (" + rt.getPocketCount(rt.getColdestPocket()) + ")");
				}	
}
