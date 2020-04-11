
public class Gym {
	
	final Gate[] gates; // array of gates
	final int capacity; // capacity of the gym
	
	// initialize with number of gates set to 3 and capacity set to 1000
	public Gym() {
		this.capacity=1000;
		this.gates=new Gate[3];
	}
	// initialize with specified number of gates and capacity set to 1000
	public Gym(int numOfGates) {
		this.capacity=1000;
		this.gates= new Gate[numOfGates];
		// TODO
	}
	// initialize with specified number of gates and with specified capacity
	public Gym(int numOfGates, int capacity) {
		this.capacity=capacity;
		this.gates= new Gate[numOfGates];
		
	}
	
	// lock all gates
	public void lockDown() {
		for (int i=0; i<this.gates.length-1; i++)
			{
			gates[i].tripod = State.LOCKED;	
			}
	}
	
	// open (roughly) half of the gates for in and the other half for out
	public void open() {
		for (int i=0; i<this.gates.length-1; i++)
		{
			if(gates[i].tripodState()== State.LOCKED){
				
				if(i==0 || gates[i-1].tripodState()== State.OUT){
				gates[i].setTripod(State.IN);
				}
				else{
				gates[i].setTripod(State.OUT);
				}
			}
		}
	}

	// if numOfInGate >= gates.length, then open (gates.length-1) gates for in and 1 for out
	// if numOfInGate <= 0, then open 1 gate for in and rest for out
	// otherwise, open "numOfInGate" gates for in and leave the rest for out
	public void open(int numOfInGate) { 
		if (numOfInGate >= gates.length){
			gates[0].setTripod(State.OUT);
			for (int j=1; j<this.gates.length-1; j++)
			{
				gates[j].setTripod(State.IN);
			}
		}
		if (numOfInGate <=0){
			gates[0].setTripod(State.IN);
			for (int j=1; j<this.gates.length-1; j++)
			{
				gates[j].setTripod(State.OUT);
			}
		}
		else{
			for (int j=0; j<this.gates.length-1; j++)
			{
				if(j<numOfInGate){
				gates[j].setTripod(State.IN);
				}
				else{
				gates[j].setTripod(State.OUT);
				}
			}
		}
	}
	
	// enters 1 person at gates[gateNumber] if the persons inside do not exceed capacity 
	// do nothing is the gateNumber is not legal
	public void getIn(int gateNumber) {
			if (gates[gateNumber].tripodState()== State.IN && canGoIn()) {
			gates[gateNumber].personGoneInside += 1;
			} 
		}
	// exits 1 person at gates[gateNumber] if there is at least 1 person inside
	// do nothing is the gateNumber is not legal
	public void getOut(int gateNumber) {
		
		if(gates[gateNumber].tripodState()== State.OUT && canGoOut()){
			gates[gateNumber].personGoneInside -= 1;
		}
	}
	// returns true if and only if capacity is not reached
	public boolean canGoIn() {
		boolean ent;
		ent= this.capacity > personsInside();
		return ent;
	}
	// returns true if and only if it is not empty
	public boolean canGoOut() {
		boolean ext;
		
		ext= personsInside() > 0;
		return ext;
	}
	// return the number of persons inside the gym
	public int personsInside() {
		int personsInside=0;
		for (int i=0; i<gates.length-1; i++){
			personsInside += gates[i].personGoneInside;
		}
		return personsInside;
	}
	// print each gate of the gym
	@Override
	public String toString() {
		String gstring = "";
		for (int i=0; i<gates.length-1; i++){
			gstring += gates[i].toString() + "\n";
		}
		return gstring;	
		}
}
