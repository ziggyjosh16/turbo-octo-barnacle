import java.util.*;

public class program01 {
	public static void main(String[] args) {
		Scanner in = new Scanner(System.in);
		double idealArray[] = { 0.0, 0.2, 0.4, 0.6, 0.8, 1, 1.2, 1.4, 1.6, 1.8,
				2.0, 2.2, 2.4, 2.6, 2.8, 3, 3.2, 3.4, 3.6, 3.8 };
		double noisyArray[] = { 0.008976173, 0.015300936, 0.38730289,
				0.65415467, 0.705971749, 1.307427486, 1.071969875, 1.11358872,
				1.688798266, 1.334709476, 2.40411576, 2.310886173, 2.432582514,
				2.174252365, 2.727890154, 3.222288922, 3.43265852, 3.823261752,
				3.184157161, 3.933609629 };
		System.out.println("Please enter the size of the filter array");
		int size = in.nextInt();
		if (size < 1 || size % 2 == 0/* (even number) */) {
			System.out
					.println("Size of array should be a positive odd number!");
			System.out.println("Goodbye");
		} else {
			double[] filters = new double[size];
			System.out
					.println("Please enter the values of the filter (seperated by space)");
			for (int i = 0; i < size; i++) {
				filters[i] = in.nextDouble();
			}
			double[] filtered = filterSignal(noisyArray, filters);
			System.out.println("Your Filtered Array: ");
			System.out.println("-------------------------");
			double sum = 0;
			for (int a = (int) filters.length / 2; a < filtered.length
					- filters.length / 2; a++) {

				sum = sum + Math.abs(filtered[a] - idealArray[a]);
				System.out.println(filtered[a]);
			}
			int size2 = idealArray.length - (filters.length - 1);
			double absdif = sum / size2;
			System.out
					.println("The average absolute difference from the idealSignal is: "
							+ absdif);
			System.out.println("GOODBYE");
		}

	}

	public static double[] filterSignal(double[] values, double[] filter) {
		double[] filtering = new double[20];
		int length = filter.length;
		int dev = (int) length / 2; // determines the first value in the noise
		// array that can be filtered
		for (int i = dev; i < values.length - (dev); i++) {
			double number = 0;/* sum of filtered values */
			for (int j = 0; j < filter.length; j++) {

				number = number + values[i - ((filter.length - 1) / 2) + j]
						* filter[j];
			}
			filtering[i] = number;

		}

		return filtering;
	}
}
