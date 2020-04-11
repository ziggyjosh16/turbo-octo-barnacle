import java.util.ArrayList;
import java.util.Random;

public class CardDeck {
	private ArrayList<Card> deck = new ArrayList<Card>();
	Random rand = new Random();
	
	public CardDeck() {
		for (int i = 1; i < 13; i++) {
			deck.add(new Card(i,1));
			deck.add(new Card(i,2));
			deck.add(new Card(i,3));
			deck.add(new Card(i,4));
		}
	}
	public Card nextCard() {
		if (deck.isEmpty()) 
			return null;
		else {
			int index = rand.nextInt(deck.size());
			return deck.remove(index);
		}
	}

}
