import java.util.*;

public class NineCardsDriver {
	public static void main(String[] args) {
		CardDeck decky = new CardDeck();
		Scanner prompt = new Scanner(System.in);
		Player p1 = new Player(null, decky.nextCard(), decky.nextCard(),
				decky.nextCard());
		Player p2 = new Player(null, decky.nextCard(), decky.nextCard(),
				decky.nextCard());
		Player p3 = new Player(null, decky.nextCard(), decky.nextCard(),
				decky.nextCard());
		System.out.println("Welcome to the Nine Cards Program");
		System.out.println();
		System.out.println("Enter the name of Player 1: ");
		p1.setName(prompt.nextLine());
		System.out.println("Enter the name of Player 2: ");
		p2.setName(prompt.nextLine());
		System.out.println("Enter the name of Player 3: ");
		p3.setName(prompt.nextLine());

		System.out.println(p1.toString());
		System.out.println(p2.toString());
		System.out.println(p3.toString());

		while (puzzleSolved(p1, p2, p3) == false) {
			printGameStatus(p1, p2, p3);
			System.out.println(p1.toString());
			System.out.println(p2.toString());
			System.out.println(p3.toString());
			System.out
					.println("Enter numbers of players to swap (space seperated): ");
			int him;
			int her;
			him = prompt.nextInt();
			her = prompt.nextInt();
			System.out
					.println("Enter number of cards to swap (space seperated): ");
			// prompt
			int hiscard;
			int hercard;
			hercard = prompt.nextInt();
			hiscard = prompt.nextInt();
			Card hold;
			if (him==1 && her ==2)
			{
				
				 p2.setCard(hiscard,p1.getCard(hercard));
			}
		}
		System.out.println("Congratulations! You solved the Puzzle!");
		System.out.println("Results: ");
		System.out.println("-------------------");
		System.out.println(p1.toString());
		System.out.println(p2.toString());
		System.out.println(p3.toString());
		System.out.println("Goodbye!");
	}
	

	private static void printGameStatus(Player p1, Player p2, Player p3) {
		System.out.println("Game Status");
		System.out.println("===========");
		System.out.println("Player 1 (" + p1.getName() + "): "
				+ p1.getNumColors() + " colors, " + p1.getNumNumbers()
				+ " numbers");
		System.out.println("Player 2 (" + p2.getName() + "): "
				+ p2.getNumColors() + " colors, " + p2.getNumNumbers()
				+ " numbers");
		System.out.println("Player 3 (" + p3.getName() + "): "
				+ p3.getNumColors() + " colors, " + p3.getNumNumbers()
				+ " numbers");

	}// end printGameStatus

	private static boolean puzzleSolved(Player p1, Player p2, Player p3) {
		if (p1.getNumNumbers() == 1 || p1.getNumColors() == 1) {
			if (p2.getNumNumbers() == 1 || p2.getNumColors() == 1) {
				if (p3.getNumNumbers() == 1 || p3.getNumColors() == 1) {
					return true;
				}
			}
		}

		return false;

	}// end puzzleSolved
}
