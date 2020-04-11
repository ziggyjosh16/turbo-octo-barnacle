

public class Gym {
	final Gate[] gates;
	final int capacity;
	final GymController controller;

	// Initialize a gym controller with the "occupancy" parameter and "this" 
	//    and save it in the field "controller"
	public Gym(int numOfGates, int capacity, double occupancy) {
		// TODO
		this.controller= new GymController(occupancy, this);
		this.gates= new Gate[numOfGates];
		for(int i=0; i<numOfGates; i++) {
			this.gates[i] = new Gate("gate_"+i);
		}
		this.capacity = capacity;
		
	}
	// Call previous constructor with default occupancy set to 0.5
	public Gym(int numOfGates, int capacity) {
		// TODO
		this(numOfGates, capacity, 0.5);
		
	}
	// Call previous constructor with default capacity set to 1000
	public Gym(int numOfGates) {
		// TODO
		this(numOfGates, 1000);
	}
	// Call previous constructor with default number of gates set to 3
	public Gym() {
		// TODO
		this(3);
	}

	public void lockDown() {
		// Use previous solution
		for(int i=0; i<gates.length; i++){
			 gates[i].close();
		}
	}

	public void open() {
		// Use previous solution
		this.open(gates.length/2);

	}
	public void open(int numOfInGate) { 
		// Use previous solution
		if (numOfInGate >= gates.length) {
			numOfInGate = gates.length - 1;
		}
		else if(numOfInGate <= 0) {
			numOfInGate = 1;
		}
				
		for(int i=0; i<numOfInGate; i++) {
			gates[i].open(State.IN);
		}
		for(int i=numOfInGate; i<gates.length; i++) {
			gates[i].open(State.OUT);
		}
		
	}

	// find one gate that is not at the "state" (if exists) and set its tripod state to that "state"
	public void switchOneGate(State state) {
		for (int i=0; i<this.gates.length; i++)
		{
			if (gates[i].tripodState()!=state){
				gates[i].setTripod(state);
				break;
			}
		}
	}
	
	// Return the number of gates in "state"
	public int numberOfGatesInState(State state) {
		// TODO
		int ret=0;
		for (int i=0; i<this.gates.length; i++)
		{
			if (gates[i].tripodState()==state){
			++ret;
			}
		}
		return ret;
	}
	
	// Return the total number of gates
	public int numberOfGates() {
		return this.gates.length;
	}
	
	public void getIn(int gateNumber) {
		if(0 <= gateNumber && gateNumber < gates.length && canGoIn()) {
			gates[gateNumber].getIn(1);
		}
	}
	
	public void getOut(int gateNumber) {
		if(0 <= gateNumber && gateNumber < gates.length && canGoOut()) {
			gates[gateNumber].getOut(1);
		}
	}
	public boolean canGoIn() {
		// Use previous solution
		return personsInside() < this.capacity;
	}
	public boolean canGoOut() {
		return personsInside() > 0;
	}
	
	// Call the onChange method of "controller"
	public int personsInside() {
		int sum = 0;
		for(int i=0; i<gates.length; i++) {
			sum += gates[i].numPersonGoneInside();
		}
		// TODO: call onChange method of "controller" with "sum" 
		this.controller.onChange(sum);
		return sum;
	}

	@Override
	public String toString() {
		// Use previous solution
		String g = " ";
		for(int i=0; i<gates.length; i++){
			g += gates[i].toString();
		}
		return g;
	}
	
}
