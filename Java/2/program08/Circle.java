
public class Circle extends NamedShape {
private Point center;
private double radius;
public Circle(String n, Point center, double Radius)
{
	super(n);
	this.center=center;
	this.radius=Radius;
}
public Point center() {
	
	return this.center;
}
public double getRadius()
{
	return this.radius;
}
public Point Center()
{
	return this.center;
}
public boolean contains(Point p)
{
	if(this.center.x + this.radius >=p.x || this.center.y + this.radius== p.y)
	{
		return true;
	}
	else
	{
		return false;
	}
}
public double area()
{
	double area=0.0;
	return area= Math.PI*Math.pow(this.radius, 2);
}
public String toString()
{
	return "C:("+this.center.toString()+ "," + this.radius + ")";
}

}
