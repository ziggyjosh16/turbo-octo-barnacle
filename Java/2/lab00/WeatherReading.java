
public class WeatherReading 
{
	
		private double temperature=0;
		private double windspeed=0;
		private double windchill;
	
	public void setTemperature(double temperature)
	{
		this.temperature= temperature;
		if (temperature > 50)
		{
			System.out.println("Temperatures above 50 degrees are insignificant");
		}
	}
	public void setWindSpeed(double windspeed)
	{
		 this.windspeed= windspeed;
		 if (windspeed<0)
		 {
			 System.out.println("Wind speeds cannot be negative");
		 }
		 if (windspeed < 3)
		 {
			 System.out.println("windspeeds less than 3MPH are insignificant");
		 }
	}
	public double getTemperature()
	{
		return this.temperature;
	}
	public double getWindSpeed()
	{
		return this.windspeed;
	}
	public double windChill()
	{
		return this.windchill= 35.74+ (.6215*temperature)-(35.75*Math.pow(windspeed, 0.16))+ (.4275*temperature*Math.pow(windspeed, 0.16));
	}
}
