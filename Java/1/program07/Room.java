

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
	@Override
	public String toString() {
		// From hwk6
		return this.numOfWindows+ " (" + this.window.toString() + ")";

	}
	@Override
	public boolean equals(Object that){
		// From hwk6
		boolean equi;
		if (that instanceof Room){
			Room thatRoom= (Room) that;
			equi= this.window.equals(thatRoom.window) && this.numOfWindows == thatRoom.numOfWindows;
		}
		else{
			equi = false;
		}
		return equi;
	}
}

class MasterBedroom extends Room {
	MasterBedroom() {
		super(new Window(4, 6), 3);
	}
	@Override
	public String toString() {
		// From hwk6
		return "Master bedroom: " +  super.toString();

	}
}

class GuestRoom extends Room {
	GuestRoom() {
		super(new Window(5, 6), 2);
	}
	@Override
	public String toString() {
		// From hwk6
		return "Guest room: " +  super.toString();

	}
}

class LivingRoom extends Room {
	LivingRoom() {
		super(new Window(6, 8), 5);
	}
	@Override
	public String toString() {
		// From hwk6
		return "Living room: " + super.toString();

	}
}
