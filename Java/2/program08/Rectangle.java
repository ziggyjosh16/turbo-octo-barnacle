public class Rectangle extends NamedShape {
	protected Point tl;
	protected Point br;

	public Rectangle(String n, Point tleft, Point bright) {
		super(n);
		this.br = bright;
		this.tl = tleft;
	}

	public Point getTLeft() {
		return this.tl;
	}

	public Point getBRight() {
		return this.br;
	}

	public Point center() {
		double xCenter = (this.tl.getX() + this.br.getX()) / 2;
		double yCenter = (this.tl.getY() + this.br.getY()) / 2;
		return new Point(xCenter, yCenter);
	}

	public boolean contains(Point p) {
		if (tl.getX() >= p.getX() && tl.getY() >= p.getY()
				|| br.getX() >= p.getX() && br.getY() >= p.getY()) {
			return true;
		} else {
			return false;
		}
	}

	public double area()
	{
		Point forlength=new Point(this.tl.getX(), this.br.getY());
		double length=Math.abs(this.tl.getY()-forlength.getY());
		double width= Math.abs(forlength.getX()-this.br.getX());
		double area=length*width;
		return area;
	}
	public String toString()
	{
		return "" + super.getNamedShape() + " : (" + this.tl+ "," +
	this.br + ")";
		
	}
}
