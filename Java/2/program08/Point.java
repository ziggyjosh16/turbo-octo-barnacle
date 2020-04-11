
public class Point extends Shape {
protected double x;
protected double y;
public Point()
{
	this (0.0,0.0);
}
public Point(double x, double y)
{
	this.x=x;
	this.y=y;
}
public double getX()
{
	return this.x;
}
public double getY()
{
	return this.y;
}
public Point center()
{
	return this.center();
}
public boolean contains(Point p)
{
	if (this.x== p.x && this.y==p.y)
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
	return 0.0;
}
public double distance(Point p)
{
	double distance= Math.sqrt(Math.pow((this.x-p.x), 2)+Math.pow((this.y-p.y),2));
	return distance;
}
public String toString()
{
	return "(" + this.getX()+"," + this.getY() + ")"; 
}
}
