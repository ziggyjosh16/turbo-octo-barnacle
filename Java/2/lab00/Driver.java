import java.util.Scanner;
public class Driver {
 public static void main(String[] args) {
 Scanner stdIn = new Scanner(System.in);
 WeatherReading current = new WeatherReading();
 System.out.print("Enter current temperature (deg. F): ");
 current.setTemperature(stdIn.nextDouble());
 System.out.print("Enter current wind speed (mph): ");
 current.setWindSpeed(stdIn.nextDouble());
 System.out.printf("Temp = %.1f, Wind = %.1f, Wind Chill = %.1f\n",
current.getTemperature(), current.getWindSpeed(),
current.windChill());
 }
}