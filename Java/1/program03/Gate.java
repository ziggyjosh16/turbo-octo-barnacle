

enum State {IN, OUT, LOCKED}

public class Gate { 
	private State tripod= State.LOCKED;
	// If negative, then it means the number of persons gone outside through this gate
	private int personGoneInside = 0; 
	private String name;
	
	// Gate Constructor
	public Gate(String name) { 
		new Gate(name, tripod);
	}
	
	public Gate(String name, State state) {
		this.name=name;
		this.tripod=state;
	}

	public int numPersonGoneInside() {
		return this.personGoneInside; // TODO  
	}
	
	// To set the tripod state
	public void setTripod(State dir) {
		this.tripod=dir;// TODO 
	}

	// return true if and only if the gate is currently locked
	public boolean open(State dir) {
		boolean opened = false;
		if (this.tripod==State.LOCKED){
			switch(dir){
			case IN: opened=true; break;
			case OUT: opened=true; break;
			default: opened=false;
			}
		this.tripod=dir;
		}
		return opened;
	}

	// to close the gate
	public void close() {
		this.tripod=State.LOCKED;// TODO
	}

	// to check if the gate is locked or not
	public boolean isLocked() {
		boolean locked=false;
		if (this.tripod != State.LOCKED)
		{
			locked = false;
		}
		else{
			locked = true;
		}
		return locked;
	}

	// to return the tripod state
	public State tripodState() {
		return this.tripod; // TODO 
	}

	// x number of person wants to get in through this gate
	public void getIn(int x) { 
		if (this.tripod==State.IN)
		{
			 this.personGoneInside+=x;// TODO 
		}
		else{
			this.personGoneInside+=0;
		}
	}

	// x number of person wants to get out through this gate
	public void getOut(int x) {
		if (this.tripod==State.OUT)
		{
			 this.personGoneInside-=x;// TODO 
		}
		else{
			this.personGoneInside+=0;
		}
	}

	@Override
	public String toString() {
		return "Gate " + this.name + " is open to get " + this.tripodState() + ".\n" +	Math.abs(this.personGoneInside) + " came " + this.tripodState() + " through this gate."; 
		
		}
	}


