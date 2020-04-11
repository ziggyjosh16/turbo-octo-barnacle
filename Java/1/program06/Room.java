
public class Room { 
	Window window;
	int numOfWindows;
	
	Room(Window window, int numOfWindows) { 
		this.window = window;
		this.numOfWindows = numOfWindows;
	}
	 
	WindowOrder order() {
		return new WindowOrder(window, numOfWindows);
	}

	// Print text like: 5 (6 X 8 window)
	@Override
	public String toString() {
		return this.numOfWindows+ " (" + this.window.toString() + ")";
		// TODO
	}

	// Two rooms are equal if they contain the same number of windows of the same size
	@Override
	public boolean equals(Object that) {
		boolean equi;
		if (that instanceof Room){
			Room thatRoom= (Room) that;
			equi= this.window.equals(thatRoom.window) && this.numOfWindows == thatRoom.numOfWindows;
		}
		else{
			equi = false;
		}
		return equi;
		// TODO
	}
}

class MasterBedroom extends Room {
	MasterBedroom() {
		super(new Window(4, 6), 3);
	}

	// Call parent's toString method
	//
	// return text like: Master bedroom: 3 (4 X 6 window)
	@Override
	public String toString() {
		return "Master bedroom: " +  super.toString();
		// TODO
	}
}

class GuestRoom extends Room {
	GuestRoom() {
		super(new Window(5, 6), 2);
	}

	// Call parent's toString method
	//
	// return text like: Guest room: 2 (5 X 6 window)
	@Override
	public String toString() {
		return "Guest room: " +  super.toString();

		// TODO
	}
}

class LivingRoom extends Room {
	LivingRoom() {
		super(new Window(6, 8), 5);
	}

	// Call parent's toString method
	//
	// return text like: Living room: 5 (6 X 8 window)
	@Override
	public String toString() {
		return "Living room: " + super.toString();
	}
}


