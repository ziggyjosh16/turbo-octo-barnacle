

import java.util.ArrayList;
import java.util.List;

// This class represents a collection of window orders using an ArrayList
public class TotalOrder {
	List<WindowOrder> orders = new ArrayList<>();
	// Add a new window order to this list
	// Make sure to merge the orders for window of the same size
	// Return the current object
	TotalOrder add(WindowOrder newOrder) {
		for (int i=0; i<orders.size(); i++){
			if  (orders.get(i).equals(newOrder)){
				orders.add(orders.get(i).add(newOrder));
				orders.remove(i);
			}
		}
		orders.add(newOrder);
		return this;
	}
	
	// Add another collection of window order
	// Also make sure that the orders for windows of the same size are merged
	// Return the current object
	TotalOrder add(TotalOrder that) {
 for (int i=0; i<that.orders.size(); i++){
		 orders.add(that.orders.get(i));
	 }
	 return this;
	}
	
	// Multiple all window orders by "num"
	TotalOrder times(int num) {
		TotalOrder timeOrders= new TotalOrder();
		for (int i=0; i<orders.size(); i++){
				timeOrders.add(this.orders.get(i).times(num));
		}
		return timeOrders;
	}
	
	@Override
	public String toString() {
		String ret= "";
		for (int i=0; i<orders.size(); i++){
			ret+= orders.get(i).toString();
		}
		return ret;
	}
}
