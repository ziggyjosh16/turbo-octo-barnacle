import java.util.*;

// (sakjbfksd+56+d+d+f6+d6fd+f)(1+2+3+4+5   )(1 )(1  +-1)(3+  45+)(9/5  ) (9+2 +3+1+2+0)
public class ExprParser {
	public static void main(String[] args) {
		Scanner read = new Scanner(System.in);
		System.out.println("Welcome to the Expression calculator program");
		System.out.println("Please enter a line of expressions");
		String expression;
		expression = read.nextLine();
		int sum = 0;
		String split = "";
		do {
			boolean parsable;
				split = expression.substring(expression.indexOf('('),
						expression.indexOf(')') + 1);
				expression = expression.substring(expression.indexOf(')') + 1);
				System.out.println("The expression entered: " + split);
				parsable = validateExp(split);
				if (parsable == true) {

					sum = strParser(split);
					System.out.println("The sum of this expression is: " + sum);
					System.out.println();
				} else {
					System.out.println("This expression cannot be evaluated");
					System.out
							.println("----------------------------------------");
					System.out.println();
				}
			

		} while (expression.isEmpty() == false);
	}

	// this method handles only single expressions, one at a time,
	// only considering content inside the parentheses.
	public static int strParser(String singexpression) {
		singexpression = singexpression.replace("(", " ");
		singexpression = singexpression.replace(")", " ");
		singexpression = singexpression.replaceAll("\\s+", "");
		singexpression = singexpression.trim();
		String[] numbers = singexpression.split("\\+");
		int[] realnumbers = new int[numbers.length];
		int sum = 0;
		for (int a = 0; a < numbers.length; a++) {
			int parsed = Integer.parseInt(numbers[a]);
			realnumbers[a] = parsed;
			sum = sum + parsed;
		}

		return sum;

	}

	public static boolean validateExp(String expression) {

		expression = expression.replace("(", " ");
		expression = expression.replace(")", " ");
		expression = expression.replaceAll("\\s+", "");
		expression = expression.trim();
		
		// at this point all that remains are, invalid inputs,
		// numbers, and the + operator (no extra whitespace)
		// for empty expressions
		if (expression.isEmpty() == true) {
			System.out
					.println("INVALID EXPRESSION: expressions cannot be empty");
			return false;
		}
		// for expressions ending with + operator
		if (expression.lastIndexOf('+') == (expression.length() - 1)) {
			System.out
					.println("INVALID EXPRESSION: expressions cannot end with an operator");
			return false;
		}
		// checks string for invalid characters
		for (int i = 0; i < expression.length() - 1; i++) {
			if( Character.isAlphabetic(expression.charAt(i)) || expression.charAt(i)
					== '!'  || expression.charAt(i)== '@'  || expression.charAt(i)==
					'#'  || expression.charAt(i)== '$'  || expression.charAt(i)== 
					'%'  || expression.charAt(i)== '^'  || expression.charAt(i)== 
					'&'  || expression.charAt(i)== '*'  || expression.charAt(i)==
					'\\'  || expression.charAt(i)== '/')
				{System.out
						.println("INVALID EXPRESSION: expressions cannot have invalid characters");
				return false;
				}

		}
		
		return true;
	}

}
