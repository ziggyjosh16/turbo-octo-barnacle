import java.util.ArrayList;
import java.util.Random;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;


public class Driver {
	public static void main(String[] args) throws IOException {
		Scanner stdIn= new Scanner(System.in);
		System.out.println("Enter template filename: ");
		String filename= stdIn.next();
	
		System.out.println("Enter dictionary filename: ");
		String dictionaryName= stdIn.next();
		
		System.out.println("Enter output filename: ");
		String oFilename= stdIn.next();
		
		Template temp = loadTemplate(filename);
		Dictionary dic = loadDictionary(dictionaryName);
		stdIn.close();
		
		PrintWriter out = new PrintWriter(oFilename);
		out.println(temp.fill(dic));
		out.close();
	}
	private static Template loadTemplate(String filename) throws IOException{
		try{
		Scanner fileIn;
		fileIn= new Scanner(new FileReader(filename));
		String temp= "";
		while (fileIn.hasNextLine()){
			temp += fileIn.nextLine();
		}
		Template t1= new Template(temp);
		fileIn.close();
		return t1;
		}
		catch (FileNotFoundException e){
			System.out.println(e.getClass());
			System.out.println(e.getMessage());
			return new Template("");
		}
		
	}
	private static Dictionary loadDictionary(String filename) throws IOException{
		Dictionary d1 = new Dictionary();
			try{
			Scanner fileIn;
			fileIn= new Scanner(new FileReader(filename));
			while (fileIn.hasNextLine()){
			d1.addWord(fileIn.nextLine());
			}
			fileIn.close();
			}
			catch (FileNotFoundException e){
				
			}
			
			return d1;
		
		
	}
}

//////////////////////////////////////////////////////////////////

class Dictionary {
	private ArrayList<String> nouns= new ArrayList<String>();
	private ArrayList<String>  verbs= new ArrayList<String>();
	private ArrayList<String>  adjectives= new ArrayList<String>();
	private ArrayList<String>  adverbs= new ArrayList<String>();
	private ArrayList<String>  pronouns= new ArrayList<String>();
	private ArrayList<String>  interjections= new ArrayList<String>();

public void addWord(String line) throws UnsupportedCategoryException{
	line.trim();
	int index=line.indexOf(":");
	if(index == -1){
		throw new DictionaryFormatException("");
	}
	String s1= line.substring(0,(line.indexOf(":")));
	String s2= line.substring(line.indexOf(":")+1);
	s2= format(s2);
	
	switch (format(s1)){
		case "noun": nouns.add(s2);
		break;
		
		case "verb": verbs.add(s2);
		break;
		
		case "adjective": adjectives.add(s2);
		break;
		
		case "adverb": adverbs.add(s2);
		break;
		
		case "pronoun": pronouns.add(s2);
		break;
		
		case "interjection": interjections.add(s2);
		break;
		
		default: throw new UnsupportedCategoryException("[Error]: Unsupported category: '"+ format(s1)+ "'");
		}
}
public String getWord(String partOfSpeech) throws UnsupportedCategoryException, EmptyWordListException{
	Random r=new Random();
	int n=0;
	String ret= "";
	try{
		
		switch (format(partOfSpeech))
		{
		case "noun":  n=r.nextInt(nouns.size());
		ret = nouns.get(n);
		nouns.remove(n);
		return ret;
		
		case "verb": n=r.nextInt(verbs.size());
		ret = verbs.get(n);
		verbs.remove(n);
		return ret;
		
		case "adjective":  n=r.nextInt(adjectives.size());
		ret = adjectives.get(n);
		adjectives.remove(n);
		return ret;
		
		case "adverb":  n=r.nextInt(adverbs.size());
		ret = adverbs.get(n);
		adverbs.remove(n);
		return ret;
		
		case "pronoun":  n=r.nextInt(pronouns.size());
		ret = pronouns.get(n);
		pronouns.remove(n);
		return ret;

		
		case "interjection":  n=r.nextInt(interjections.size());
		ret = interjections.get(n);
		interjections.remove(n);
		return ret;
		
		default: throw new UnsupportedCategoryException("[Error]: Unsupported category: '" + partOfSpeech + "'");
		}
		}
	catch (IllegalArgumentException e){
		throw new EmptyWordListException("[Error]: No remaining words of category: '"+ partOfSpeech + "'");
		}
	}
public String format(String s){
	s= s.trim();
	s= s.toLowerCase();
	 return s;
}
}
/////////////////////////////////////////////////////////////////////////////////

class Template {
private String template;
	public Template(String template){
		this.template=template;
	}
	public String fill(Dictionary Dictionary){
	String s= template;

	s.replaceAll("adjective", Dictionary.getWord("adjectives"));
	s.replaceAll("noun", Dictionary.getWord("nouns"));
	s.replaceAll("adverb", Dictionary.getWord("adverbs"));
	s.replaceAll("verb", Dictionary.getWord("verbs"));
	s.replaceAll("noun", Dictionary.getWord("nouns"));
	s.replaceAll("interjection", Dictionary.getWord("interjections"));
	s.replaceAll("pronoun", Dictionary.getWord("pronouns"));

	
	return s;	
	}

}

class DictionaryFormatException extends RuntimeException {

	  public DictionaryFormatException(String message) {
	        super(message);
	    }

	    public DictionaryFormatException(String message, Throwable throwable) {
	        super(message, throwable);
	    }
}
class EmptyWordListException extends RuntimeException{

	  public EmptyWordListException(String message) {
	        super(message);
	    }

	    public EmptyWordListException(String message, Throwable throwable) {
	        super(message, throwable);
	    }
}

class UnsupportedCategoryException extends RuntimeException {

    public UnsupportedCategoryException(String message) {
        super(message);
    }

    public UnsupportedCategoryException(String message, Throwable throwable) {
        super(message, throwable);
    }

}