package homework1;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;

import javax.management.RuntimeErrorException;

import java.util.ArrayList;
import java.util.Random;

public class Eliza {

	public static void main(String[] args) throws NullPointerException, IOException {
		// TODO Auto-generated method stub
		String filename= "answers/answers.txt";
		Category[] data= loadAnswers(filename);	
		System.out.println("I am Eliza, cybertherapist.");
		Scanner stdIn=new Scanner(System.in);
		String troubles = "";
		System.out.println("What troubles you?");
		troubles = stdIn.next();
		while (!troubles.trim().equalsIgnoreCase("quit")){
			
			try{
			for (int i =0; i<data.length; ++i)
			{
				if (troubles.contains(data[i].getName()) )
				{
					System.out.println(data[i].getResponse());
					break;
				}
			}
			}
			catch(NullPointerException e){
				System.out.println("Tell me more");
			}
			
			System.out.println("What troubles you?");
			troubles = stdIn.next();
		}
		System.out.println("Goodbye!");
		stdIn.close();
	}
	
	//accepts up to 20 categories
	private static Category[] loadAnswers(String filename) throws IOException{
		int index=-1;
		Category[] cats= new Category[20];
		try{
			Scanner fileIn;
			fileIn= new Scanner(new FileReader(filename));
			while(fileIn.hasNextLine() && index <= 19){
				String c=fileIn.nextLine();
			if (!isResponse(c) && !c.equals("")){
				index++;
				cats[index]= new Category(c);
			}
			else if (isResponse(c) && !c.equals("")){
				cats[index].addResponse(c);
			}
			}
			fileIn.close();
			return cats;
		}
			catch (FileNotFoundException e){
				System.out.println(e.getClass());
				System.out.println(e.getMessage());
			}
		return cats;
		}

	public static boolean isResponse(String line){
		if (line.contains(":")){
			return false;
		}
		return true;
	}
}
	
	
	
	
	
class Category {
	private String category;
	private ArrayList<String> responses;

	public Category(){
		this.category= "";
		this.responses= new ArrayList<String>();
	}
	public Category(String line){
		line=format(line);
		this.category = line.substring(line.indexOf(":")+1);
		this.responses= new ArrayList<String>();
	}
	public void addResponse(String line){
		this.responses.add(line);
	}
	public String getName(){
		return this.category;
	}
	public String getResponse(){
		Random r=new Random();
		int n;
		n= r.nextInt(responses.size());
		String ret= "";
		ret= responses.get(n);
		return ret;
	}
	
	public String format(String s){
		return s.trim().toLowerCase();
	}

		
}



class UnsupportedCategoryException extends RuntimeException{
	public UnsupportedCategoryException(String message){
		super(message);
	}
	public UnsupportedCategoryException(String message, Throwable throwable) {
		super(message, throwable);
	}
}
