import java.util.*;

public class BridgeHand {
	private ArrayList<Card> hand = new ArrayList<Card>();

	public BridgeHand() {

	}

	public void addCard(Card c) {
		hand.add(c);
		
	}

	public int getBiddingPoints() {
		int points = 0;
		for (int i = 0; i < hand.size(); i++) {
			if (hand.get(i).getNumber() == 1) {
				points = points + 4;
			} else if (hand.get(i).getNumber() == 13) {
				points = points + 3;
			} else if (hand.get(i).getNumber() == 12) {
				points = points + 2;
			} else if (hand.get(i).getNumber() == 11) {
				points++;
			} else if (hand.get(i) == null) {
				points = points + 0;
			}
		}
		return points;
	}

	public String toString() {
		return "" + this.hand + "";
	}
}
