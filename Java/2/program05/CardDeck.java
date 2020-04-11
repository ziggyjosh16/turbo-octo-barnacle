import java.util.ArrayList;
import java.util.Random;

public class CardDeck {
	private ArrayList<Card> deck = new ArrayList<Card>();
	Random rand = new Random();
	
	public CardDeck() {
		for (int i = 1; i < 4; i++) {
			deck.add(new Card(i, 'R'));
			deck.add(new Card(i, 'G'));
			deck.add(new Card(i, 'B'));
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