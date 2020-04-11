
public class GymController {
	final double toleranceIncrement = 0.01;

	double outTolerance = toleranceIncrement, inTolerance = toleranceIncrement;

	final double occupancy; // target ratio of occupancy
	final Gym gym; // gym object under control

	// Save occupancy ratio and gym object
	// Make sure the occupancy parameter between 0 and 1; if not, set it to 0.5
	// Check tolerances to ensure they are legal with respect to the target occupancy ratio
	GymController(double occupancy, Gym gym) {
		// TODO
		
		if (occupancy > 1 || occupancy<0)
		{
			this.occupancy=0.5;
		}
		else{
			this.occupancy=occupancy;
		}
		this.gym=gym;
	}

	// Make sure tolerances are legal and
	// change tolerances if necessary so that occupancy + upperTolerance <= 1 and 
	//                                        occupancy - lowerTolerance >= 0
	private void checkTolerance() {
		this.outTolerance = Math.min(this.outTolerance, 1 - this.occupancy);
		this.inTolerance = Math.min(this.inTolerance, this.occupancy);
	}

	// Increment out tolerance and 
	// decrement in tolerance (if it is > tolerance increment)
	// and also ensure they are legal
	private void adjustToleranceForOut() {
		// TODO
		this.outTolerance += this.toleranceIncrement;

		if(this.inTolerance > this.toleranceIncrement){
			this.inTolerance -= this.toleranceIncrement;
		}
		checkTolerance();
	}

	// Increment in tolerance and 
	// decrement out tolerance (if it is > tolerance increment) 
	// and also ensure they are legal
	private void adjustToleranceForIn() {
		this.inTolerance += this.toleranceIncrement;

		if(this.outTolerance > this.toleranceIncrement){
			this.outTolerance -= this.toleranceIncrement;
		}
		checkTolerance();	// TODO
	}

	// This is called by the personsInside method of the gym object  
	// If the current occupancy ratio is greater than the target occupancy + out tolerance 
	//  and there are more than one gate that are not in OUT state
	// then switch one gate to OUT state
	//
	// If the current occupancy ratio is less than the target occupancy - in tolerance
	//  and there are more than one gate that are not in IN state
	// then switch one gate to IN state
	//	
	// When a gate is switched to IN or OUT, adjust corresponding tolerance
	public void onChange(int personsInside) {
		// TODO
		if ((personsInside/this.gym.capacity > this.occupancy+this.outTolerance) 
				&& this.gym.numberOfGatesInState(State.IN)>1){
			this.gym.switchOneGate(State.OUT);
			adjustToleranceForIn();
		}
		if ((personsInside/this.gym.capacity < this.occupancy-this.inTolerance)
				&& this.gym.numberOfGatesInState(State.OUT)>1){
			this.gym.switchOneGate(State.OUT);
			adjustToleranceForOut();
		}
		
	}
}
