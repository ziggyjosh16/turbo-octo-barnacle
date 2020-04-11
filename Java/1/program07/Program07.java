
public class Program07 {
		public static void main(String[] args) {
			Apartment[] apartments = { new OneBedroom(20), new TwoBedroom(15), new ThreeBedroom(10) };
			
			Building building = new Building(apartments);
			
			TotalOrder orders = building.order();
			
			System.out.println(building);
			
			System.out.println("Window orders are:\n" + orders); 
		}
	}



