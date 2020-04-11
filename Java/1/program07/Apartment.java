public class Apartment {
	int numOfApartments; // the number of apartments of this type
	Room[] rooms; // rooms in this type of apartment
	
	Apartment(int numOfApartments, Room[] rooms) {
		this.numOfApartments = numOfApartments;
		this.rooms = rooms;
	}
	
	// Return the window orders for one apartment of this type as TotalOrder object
	TotalOrder orderForOneUnit() {
		TotalOrder aptOrder = new TotalOrder();
		for (int i=0; i<rooms.length; i++){
			aptOrder.orders.add(this.rooms[i].order());
		}
		return aptOrder;
	}
	
	// Return the window orders for all apartments of this type
	TotalOrder totalOrder() {
		TotalOrder aptTotalOrder =  orderForOneUnit();
		aptTotalOrder = aptTotalOrder.times(numOfApartments);
		return aptTotalOrder;
		
		// TODO
	}
	
	public String toString() {
		String ret= this.numOfApartments + " apartments with ";
		for (int i=0; i<rooms.length; i++){
			ret +=  "("+rooms[i].toString() +")";
		}
		
		return ret;
	}
}

class OneBedroom extends Apartment {
	OneBedroom(int numOfUnits) {
		super(numOfUnits, new Room[] { new LivingRoom(), new MasterBedroom() });
	}
}

class TwoBedroom extends Apartment {
	TwoBedroom(int numOfUnits) {
		super(numOfUnits, new Room[] { new LivingRoom(), new MasterBedroom(), new GuestRoom() });
	}
}

class ThreeBedroom extends Apartment {
	ThreeBedroom(int numOfUnits) {
		super(numOfUnits, new Room[] { new LivingRoom(), new MasterBedroom(), new GuestRoom(), new GuestRoom() });
	}
}
