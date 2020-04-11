import java.util.*;
public class RouletteTest {
final int NUM_POCKETS= 38;
private int numSpins;
private int[]pocketcount= new int[NUM_POCKETS];
public RouletteTest(int numSpins)
{
	this.numSpins=numSpins;
	Random generator= new Random();
	for(int i=0;i<numSpins;i++){
	    pocketcount[generator.nextInt(38)]++;
	}
}
public int getHottestPocket()
{
	
	int correspondingIndex=37;
	for (int i=37; i>=0; i--)
	{
		int hotpocket= this.pocketcount[i];
		if(hotpocket> this.pocketcount[correspondingIndex])
		{
			correspondingIndex= i;
		}
	}
	return correspondingIndex;
}
public int getColdestPocket()
{

	
	int correspondingIndex=37;
	for (int i=37; i>=0; i--)
	{
		int hotpocket= this.pocketcount[i];
		if(hotpocket< this.pocketcount[correspondingIndex])
		{
			correspondingIndex= i;
		}
	}
	return correspondingIndex;
}
public int getPocketCount(int numPocket)
{
	int occurances=0;
	for (int i=0; i<this.pocketcount.length; i++)
	{
		if (pocketcount[i]==numPocket)
		{
			occurances++;
		}
	}
	return occurances;
}
public double getStdDev()
{
	double stD= 0.0;
	for (int i = 0;i<37;i++)
	{
	 	 stD += Math.pow(((pocketcount[i])-(numSpins/38)),2);
	}
	stD= stD/(numSpins-1);
	stD= Math.sqrt(stD);

	return stD;
	
}
public String toString()
{
	String pox="";
	for (int i=0; i<pocketcount.length; i++)
	{
		pox += pocketcount[i] + ", ";
	}
	return pox;
}
}
