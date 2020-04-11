import java.util.*;
public class BridgeHandDriver {
	public static void main(String[] args) {
		System.out.println("Welcome to the Bridge Hand Dealer Program \n");
		System.out.println("Here are the 4 hands: \n");
		CardDeck cards = new CardDeck();
		BridgeHand h1 = new BridgeHand();
		BridgeHand h2 = new BridgeHand();
		BridgeHand h3 = new BridgeHand();
		BridgeHand h4 = new BridgeHand();
		for (int i = 0; i < 12; i++) {
			h1.addCard(cards.nextCard());
			h2.addCard(cards.nextCard());
			h3.addCard(cards.nextCard());
			h4.addCard(cards.nextCard());
		}
		
		System.out.println("Hand 1 ( " + h1.getBiddingPoints() + " points ):"
				+ h1.toString());
		System.out.println();
		System.out.println("Hand 2 ( " + h2.getBiddingPoints() + " points ):"
				+ h2.toString());
		System.out.println();
		System.out.println("Hand 3 ( " + h3.getBiddingPoints() + " points ):"
				+ h3.toString());
		System.out.println();
		System.out.println("Hand 4 ( " + h4.getBiddingPoints() + " points ):"
				+ h4.toString());
		System.out.println();
		System.out.println("Goodbye!");
	}
}
