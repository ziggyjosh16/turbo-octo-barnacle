
public abstract class  NamedShape extends Shape{
protected String Name;
public NamedShape(){
	
}
public NamedShape(String n)
{
this.Name=n;	
}
public String getNamedShape()
{
	return this.Name;
}
public void setName(String n)
{
	this.Name=n;
}

}
