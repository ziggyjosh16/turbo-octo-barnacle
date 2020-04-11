
public class Player {
private String name;
private Card card1;
private Card card2;
private Card card3;
public Player(String name, Card c1, Card c2, Card c3)
{
	this.name=name;
	this.card1=c1;
	this.card2=c2;
	this.card3=c3;
}
public String getName()
{
	return this.name;
}
public Card getCard(int cardNum)
{
	if (cardNum == card1.getNumber())
	{
		return this.card1;
	}
	if (cardNum == card2.getNumber())
	{
		return this.card2;
	}
	if (cardNum == card3.getNumber())
	{
		return this.card3;
	}
	else 
	{
		return null;
	}	
}
public void setName(String name)
{
	this.name=name;
}
public void setCard(int cardNum, Card c)
{
	if (cardNum==1)
	{
		this.card1=c;
	}
	if (cardNum ==2)
	{
		this.card2=c;
	}
	if (cardNum==3)
	{
		this.card3=c;
	}
}
public int getNumColors()
{
	char color1= card1.getColor();
	char color2= card2.getColor();
	char color3= card3.getColor();
	//code used to compare cards for all possible matches
	if (color1!=color2 && color1!=color3 && color2 != color3)
	{
		return 3;
	}
	else if(color1==color2 && color1==color3){
		return 1;
	}
	if(color1==color2 && color1!=color3);
	{
		return 2;
	}
	
}
public int getNumNumbers()
{
	//code used to compare cards for all possible matches
	int number1= card1.getNumber();
	int number2= card2.getNumber();
	int number3= card3.getNumber();
	if (number1!=number2 && number1!=number3)
	{
		return 3;
	}
	else if(number1==number2 && number1==number3){
		return 1;
	}
	if(number1==number2 && number1!=number3);
	{
		return 2;
	}
	
	
}
public String toString()
{
	return "" + this.name+ ": " + card1.toString()+" " 
			+ card2.toString()+ " " + card3.toString();
}

}
