

import static org.junit.Assert.assertTrue;

import org.junit.Test;

import java.util.Scanner;

public class Program02{
	static Scanner stdIn= new Scanner(System.in);
	
	public static void main(String []args){
		System.out.println (parse( promptAndRead(stdIn)));
		stdIn.close();
	}
	
	private static String promptAndRead(Scanner stdIn) {
		String code="";
		do {
			System.out.println("Please enter a Java if-then-else statement in one line:");
			code = stdIn.nextLine();
		} while (code.length()== 0);
		return code;
	}
	
	private static String parse(String code) {
		code.trim();
		String beginning = "";
		String elsebeginning = null;
		String arg1 = null;
		String arg2 = null;
		String arg3 = null;
		boolean done = false;
		while (!done){
	//begin search if statement syntax 
			try{
			beginning = code.substring(code.indexOf("i") , code.indexOf("f")+1);
			done = true;
			}
		catch (StringIndexOutOfBoundsException z) {
				System.out.println("Incorrect/Missing if statement. Please try again.");
				promptAndRead(stdIn);
			}	
		try{
			arg1 = code.substring(code.indexOf("(") , code.indexOf(")")+1);
			done = true;
			}
		catch (StringIndexOutOfBoundsException z) {
			done = false;
			System.out.println("Incorrect/Missing if statement. Please try again.");
			promptAndRead(stdIn);
			}	
		try{
			arg2 = code.substring(code.indexOf("{")+ 1, code.indexOf("}", code.indexOf("{")));
			//rid of whitespace
			arg2=arg2.trim();
			done = true;
			}
		catch (StringIndexOutOfBoundsException z) {
			done = false;
			System.out.println("Incorrect/Missing if statement. Please try again.");
			promptAndRead(stdIn);
			}
		//end if statement syntax
		//begin search else statement syntax
		try{
				elsebeginning = code.substring(code.indexOf("else"),code.indexOf("else")+4);
				done = true;
			}
		catch (StringIndexOutOfBoundsException z) {
			//will parse just the if statement if it exists
				done = false;
				System.out.println("Incomplete/Missing else statement. Re-formatting the if statement...");
				String parsed = beginning + " " + arg1 + " {\n\t" + arg2 + "\n}";
				
				return parsed;
			}
		try{
			arg3 = code.substring(code.indexOf("{",code.indexOf("else"))+1,code.lastIndexOf(";")+1);
			//rid of whitespace
			arg3=arg3.trim();
			done = true;
			}
		catch (StringIndexOutOfBoundsException z) {
				//will parse just the if statement if it exists
					done = false;
					System.out.println("Incomplete/Missing else statement. Re-formatting the if statement...");
					String parsed = beginning + " " + arg1 + " {\n\t" + arg2 + "\n}";
					return parsed;
			}
		}
			
		String parsed = beginning + " " + arg1 + " {\n\t" + arg2 + "\n}\n" + elsebeginning + " {\n\t" + arg3 + "\n}";
		return parsed;
			
	}
	
	
	
	/*@Test
	public void test1() {
		String input = "if (true) { return 1; } else { return 0; }";
		String output = "if (true) {\n\treturn 1;\n}\nelse {\n\treturn 0;\n}"; 
		assertTrue(parse(input).equals(output));
	}
	
	@Test
	public void test2() {
		String input = "if (true) { return 1; }";
		String output = "if (true) {\n\treturn 1;\n}"; 
		assertTrue(parse(input).equals(output));
	}
	
	@Test
	public void test3() {
		String input = "if(true){return 1;}else{return 0;}";
		String output = "if (true) {\n\treturn 1;\n}\nelse {\n\treturn 0;\n}"; 
		assertTrue(parse(input).equals(output));
	}
	
	@Test
	public void test4() {
		String input = "if(true){return 1;}";
		String output = "if (true) {\n\treturn 1;\n}"; 
		assertTrue(parse(input).equals(output));
	}
	
	@Test
	public void test5() {
		String input = "if   (true) {   return 1;     } else { return 0; }";
		String output = "if (true) {\n\treturn 1;\n}\nelse {\n\treturn 0;\n}"; 
		assertTrue(parse(input).equals(output));
	}
	
	@Test
	public void test6() {
		String input = "if   (true)   {   return 1;    }";
		String output = "if (true) {\n\treturn 1;\n}"; 
		assertTrue(parse(input).equals(output));
	}*/
}
