public class Window {
	private final int width, height;
	
	public Window(int width, int height) {
		this.width = width;
		this.height = height;
	}
	
	// print text like: 4 X 6 window
	public String toString() {
		
		return width + " X " + height + " window";
		// TODO
	}
	
	// compare window objects by their dimensions
	public boolean equals(Object that) {
		boolean eqi;
		if (that instanceof Window){
		Window thatWindow= (Window) that;
		eqi= this.width==thatWindow.width && this.height==thatWindow.height;
		}
		else{
			eqi = false;
		}
		return eqi;
	}
}

class WindowOrder {
	final Window window; // window description (its width and height)
	int num;             // number of windows for this order
	
	WindowOrder(Window window, int num) {
		this.window = window;
		this.num = num;
	}

	// add the num field of the parameter to the num field of this object
	//
	// BUT
	//
	//   do the merging only of two windows have the same size
	//   do nothing if the size does not match
	// 
	// return the current object
	WindowOrder add (WindowOrder order) {
		if (this.window.equals(order.window)){
			this.num+= order.num;
		}
		return this;
		// TODO
	}

	// update the num field of this object by multiplying it with the parameter
	// and then return the current object
	WindowOrder times(int number) {
	 
		this.num= this.num *number;
		// TODO
		return this;
	}
	
	// print text like: 20 4 X 6 window
	@Override
	public String toString() {
		return this.num + " " + this.window.toString();
		// TODO
	}

	// Two orders are equal if they contain the same number of windows of the same size.
	@Override
	public boolean equals(Object that) {
		boolean ret;
		if(that instanceof WindowOrder) {
			WindowOrder thatWindowOrder = (WindowOrder) that;
			ret = this.window.equals(thatWindowOrder.window) && this.num==thatWindowOrder.num;
		}
		else {
			ret = false;
		}
		return ret;
	}
}
