import java.util.*;

public class LoanEstimateDriver {
	public static void main(String[] args) {
		LoanEstimate loan = new LoanEstimate();
		LoanEstimate loan2 = new LoanEstimate();
		Scanner broker = new Scanner(System.in);
		System.out.println("Welcome to the Loan Amortization Program!");
		System.out.println("----------------------------------------");
		System.out.println();
		double principal, intRate;
		int years;
		do {
			System.out.print("Enter amount to borrow: ");
			principal = broker.nextDouble();
			if (principal <= 0.0) {
				System.out.println("ERROR: amount must be positive!");
			}
		} while (principal <= 0.0);
		loan.setPrincipal(principal);
		loan2.setPrincipal(principal);

		do {
			System.out.print("Enter years for loan 1: ");
			years = broker.nextInt();
			if (years <= 0) {
				System.out.println("ERROR: amount must be positive!");
			}
		} while (years <= 0);
		loan.setYears(years);

		do {
			System.out
					.print("Enter interest rate for loan 1 (as a percentage): ");
			intRate = broker.nextDouble();
			if (intRate <= 0) {
				System.out.println("ERROR: amount must be positive!");
			}
		} while (intRate <= 0);
		loan.setAnnualPercentRate(intRate);

		do {
			System.out.print("Enter years for loan 2: ");
			years = broker.nextInt();
			if (years <= 0) {
				System.out.println("ERROR: amount must be positive!");
			}
		} while (years <= 0);
		loan2.setYears(years);
		do {
			System.out
					.print("Enter interest rate for loan 2 (as a percentage): ");
			intRate = broker.nextDouble();
			if (years <= 0) {
				System.out.println("ERROR: amount must be positive!");
			}
		} while (intRate <= 0);
		loan2.setAnnualPercentRate(intRate);
		System.out.println("loan 1: " + loan.toString());
		System.out.printf("Loan 1 Monthly Payment: %, .2f\n",
				loan.getMonthlyPayment());
		System.out.printf("Loan 1 Total Cost: %, .2f\n", loan.getTotalCost());
		System.out.printf("Loan 1 Total Interest: %, .2f\n",
				loan.getTotalInterest());
		System.out.println();
		System.out.println("Loan 2: " + loan2.toString());
		System.out.printf("Loan 2 Monthly Payment: %, .2f\n",
				loan2.getMonthlyPayment());
		System.out.printf("Loan 2 Total Cost: %, .2f\n", loan2.getTotalCost());
		System.out.printf("Loan 2 Total Interest: %, .2f\n",
				loan2.getTotalInterest());
		 System.out.println();
		 bestLoanDiff(loan.getMonthlyPayment(),loan2.getMonthlyPayment());
		 bestIntDiff(loan.getTotalInterest(), loan2.getTotalInterest());

		System.out.println("\n Goodbye!");

	}
	public static void bestLoanDiff(double mp1, double mp2)
	{
		if (mp1==mp2)
		{
			System.out.println("loan 1's monthly payment amount is the same as loan 2");
		}
		else if(mp1<mp2)
		{
			System.out.println("loan 1's monthly payment is lower than loan 2 by $" + (mp2-mp1));
		}
		else 
		{
			System.out.println("loan 2's monthly payment is lower than loan 1 by $" + (mp1-mp2));
		}
	}
	public static void bestIntDiff(double int1, double int2)
	{
		if (int1==int2)
		{
			System.out.println("loan 1's interest amount is the same as loan 2");
		}
		else if(int1<int2)
		{
			System.out.println("loan 1's interest is lower than loan 2 by $" + (int2-int1));
		}
		else 
		{
			System.out.println("loan 2's interest is lower than loan 1 by $" + (int1-int2));
		}
	}

}
