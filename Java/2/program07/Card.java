public class Card {
	private int number;
	private int suit;

	// spades=4 hearts=3 diamonds=2 clubs=1
	public Card(int number, int suit) {
		this.number = number;
		this.suit = suit;
	}

	public int getNumber() {
		return this.number;
	}

	public int getSuit() {
		return this.suit;
	}

	public int CompareForSort(Card c1, Card c2) {
		if (c1.getSuit()==c2.getSuit()){
				if(c1.getNumber()==c2.getNumber())
				{
					return 0;
				}
				else if(c1.getNumber()==1 && c1.getNumber()!= c2.getNumber())
				{
					return 1;
				}
				else if(c2.getNumber()==1 && c1.getNumber()!= c2.getNumber())
				{
					return -1;
				}
				else if (c1.getNumber()>c2.getNumber())
				{
					return 1;
				}
				else if (c1.getNumber()<c2.getNumber())
				{
					return -1;
				}
				}
		if (c1.getSuit()<c2.getSuit())
		{
			return -1;
		}	
		if (c1.getSuit()>c2.getSuit())
		{
			return 1;
		}
		else return 0;

	}

	public String toString() {
		String suit;
		if (this.getSuit() == 1) {
			suit = "C";
		}
		if (this.getSuit() == 2) {
			suit = "D";
		}
		if (this.getSuit() == 3) {
			suit = "H";
		} else {
			suit = "S";
		}
		if (this.getNumber()==1)
		{
			return "A" + suit;
		}
		if (this.getNumber()==11)
		{
			return "J" + suit;
		}
		if (this.getNumber()==12)
		{
			return "Q" + suit;
		}
		if( this.getNumber()==13)
		{
			return "K" + suit;
		}
		else
		{
		return this.getNumber() + suit;
		}
	}
}
