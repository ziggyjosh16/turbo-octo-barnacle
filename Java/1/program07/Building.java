 
public class Building {
	Apartment[] apartments;
	
	public Building(Apartment[] units) {
		this.apartments = units;
	}
	
	// Return the total order all apartments in this building
	TotalOrder order(){
		TotalOrder orders = new TotalOrder();;
		for (int i=0; i<apartments.length; i++){
			orders.add(apartments[i].totalOrder());
		}
		return orders;
		// TODO
	}
	
	public String toString() {
		// From homework 6
		String ret= "";
		for (int i=0; i<apartments.length; i++){
			ret += apartments[i].toString() + "\n" ;
		}
		return ret;
	}
}
