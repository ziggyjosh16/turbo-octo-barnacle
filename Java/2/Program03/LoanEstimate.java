
public class LoanEstimate {

	private double principal;
	private int years;
	private double annualPercentRate;
	
	public double getPrincipal()
	{
		return this.principal;
	}
	public void setPrincipal(double principal)
	{
		 this.principal= principal;
	}
	public int getYears()
	{
		return this.years;
	}
	public void setYears(int years)
	{
		this.years= years;
	}
	public double getAnnualPercentRate()
	{
		return this.annualPercentRate;
	}
	public void setAnnualPercentRate(double annualPercentRate)
	{
		this.annualPercentRate= annualPercentRate;
	}
	public double getMonthlyPayment()
	{
		
	 double monthlyinterest= (annualPercentRate*0.1)/12;
	 double amountofmonths= years*12;
	 
	 double fraction= (principal*Math.pow(1+(monthlyinterest), amountofmonths))/
			 (Math.pow((1+monthlyinterest), amountofmonths)-1);
	 
	 double monthlypayment= monthlyinterest*(fraction);

	 return  monthlypayment;
	}
	public double getTotalInterest()
	{
		double TotalInterest;
		return TotalInterest= (getMonthlyPayment()*(years*12))-principal;
	}
	public double getTotalCost()
	{
		double totalCost;
		return totalCost=getMonthlyPayment()*(years*12); 
	}
	public String toString()
	{
		return "$" + principal + " for " + years + " years at " + annualPercentRate + "%";
	}
	
	
	
}
