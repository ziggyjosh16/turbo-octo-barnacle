public class Building {
	Apartment[] apartments;
	
	public Building(Apartment[] apartments) {
		this.apartments= apartments;
	}
	
	// Return an array of window orders for all apartments in the building
	// Ensure that the orders for windows of the same sizes are merged.
	WindowOrder[] order() {
		WindowOrder[] windowOrder=apartments[0].totalOrder();
		for (int i=0; i<apartments.length; i++){
		updateWindowOrder(windowOrder, apartments[i].totalOrder());	
		}
		return windowOrder;
	}
	private WindowOrder[] updateWindowOrder(WindowOrder[] orderArray, WindowOrder[] newOrderArray) {
		WindowOrder[] ret;

		if(orderArray.length < newOrderArray.length) {
		ret = newOrderArray;
		newOrderArray = orderArray;
		}
		else {
		ret = orderArray;
		}
		for(int i = 0; i < newOrderArray.length; i++) {
		ret[i].add(newOrderArray[i]);
		}
		return ret;
		}
	// return a string to represent all types of apartments in the building such as:
	// 20 apartments with (Living room: 5 (6 X 8 window))(Master bedroom: 3 (4 X 6 window))
	// 15 apartments with (Living room: 5 (6 X 8 window))(Master bedroom: 3 (4 X 6 window))(Guest room: 2 (5 X 6 window))
	// 10 apartments with (Living room: 5 (6 X 8 window))(Master bedroom: 3 (4 X 6 window))(Guest room: 2 (5 X 6 window))(Guest room: 2 (5 X 6 window))
	// 
	public String toString() {
		String ret= "";
		for (int i=0; i<apartments.length; i++){
			ret += apartments[i].toString() + "\n" ;
		}
		return ret;
	}
}
