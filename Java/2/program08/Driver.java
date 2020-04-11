import java.util.*;

public class Driver {
	public static void main(String args[]) {
		Scanner input = new Scanner(System.in);

		ArrayList<Shape> shapes = new ArrayList<Shape>();
		String type;
		String name;
		double x = 0.0;
		double y = 0.0;
		double radius;

		System.out.println("Welcome to the Shape Program!\n");
		System.out
				.print("Which Shape? \n Point(p) \n Circle(c) \n Rectangle(r) \n q to quit ");
		type = input.nextLine();
		while (!type.equals("q")) {
			if (type.equals("p")) {
				System.out.print("Enter X-Value: ");
				x = input.nextDouble();
				System.out.print("Enter Y-Value: ");
				y = input.nextDouble();
				shapes.add(new Point(x, y));
			}

			if (type.equals("c")) {
				System.out.print("Name of circle: ");
				name = input.next();
				System.out.print("Enter X-Value: ");
				x = input.nextDouble();
				System.out.print("Enter Y-Value: ");
				y = input.nextDouble();
				Point p = new Point(x, y);
				System.out.print("Enter radius: ");
				radius = input.nextDouble();
				shapes.add(new Circle(name, p, radius));
			}

			if (type.equals("r")) {
				System.out.print("Name of rectangle: ");
				name = input.next();
				System.out
						.print("Enter X-Value for top left corner of rectangle: ");
				x = input.nextDouble();
				System.out
						.print("Enter Y-Value for top left corner of rectangle: ");
				y = input.nextDouble();
				Point tl = new Point(x, y);
				System.out
						.print("Enter X-Value for bottom right corner of rectangle: ");
				x = input.nextDouble();
				System.out
						.print("Enter Y-Value for bottom right corner of rectangle: ");
				y = input.nextDouble();
				Point br = new Point(x, y);
				shapes.add(new Rectangle(name, tl, br));
			}

			if (!type.equals("p") && !type.equals("c") && !type.equals("r")
					&& !type.equals("q")) {
				System.out.println("Please enter a valid option");
			}

			System.out
					.print("\nWhat shape would you like to create? \n Point(p) \n Circle(c) \n Rectangle(r) \n  q to quit): ");
			type = input.next();
		}

		System.out.println("\nAll Shapes: " + shapes.toString());
		double sum = 0.0;
		for (int i = 0; i < shapes.size(); ++i) {
			sum += shapes.get(i).area();
		}
		System.out.println("Sum of areas of shapes: " + sum);

		System.out.println("Containment Check:");
		
		System.out.print("Please enter an X-Value: ");
		x = input.nextDouble();
		System.out.print("Please enter a Y-Value: ");
		y = input.nextDouble();
		System.out.println("");
		Point check = new Point(x, y);

		for (int i = 0; i < shapes.size(); ++i) {
			if (shapes.get(i).contains(check) == true) {
				System.out.println(shapes.get(i).toString()
						+ " contains the point." + check.toString());
			} else
				System.out.println(shapes.get(i).toString()
						+ " does not contain the point." + check.toString());
		}

		System.out.print("\nGoodbye!");
	}
}
