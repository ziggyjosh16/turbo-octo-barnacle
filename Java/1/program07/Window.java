

public class Window {
	private final int width, height;
	
	public Window(int width, int height) {
		this.width = width;
		this.height = height;
	}
	
	public String toString() {
		// From hwk6
		return width + " X " + height + " window";
	}
	
	public boolean equals(Object that) {
		// From hwk6
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
	final Window window;
	int num;
	
	WindowOrder(Window window, int num) {
		this.window = window;
		this.num = num;
	}
	WindowOrder add (WindowOrder order) {
		// From hwk6
		if (this.window.equals(order.window)){
			this.num+= order.num;
		}
		return this;
	}
	WindowOrder times(int number) {
		// From hwk6
		this.num= this.num *number;
		// TODO
		return this;
	}
	
	public String toString() {
		// From hwk6
		return this.num + " " + this.window.toString();
	}
	
	@Override
	public boolean equals(Object that) { 
		// From hwk6
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
