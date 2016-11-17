public class Bullet extends Floater {

  private float mySize;
  private float myRadius;

  Bullet(SpaceShip theShip) {
    myCenterX = theShip.getX();
    myCenterY = theShip.getY();
    myPointDirection = theShip.getPointDirection();
    double dRadians = myPointDirection * (Math.PI/180);
    myDirectionX = theShip.getDirectionX() + (5 * Math.cos(dRadians));
    myDirectionY = theShip.getDirectionY() + (5 * Math.sin(dRadians));
    mySize = 3;
    myRadius = mySize / 2;
  }

  public void move() {
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;
    myCenterY += myDirectionY;
  }

  public void show() {
    fill(255);
    ellipse((int)myCenterX, (int)myCenterY, mySize, mySize);
  }

  public void setX(int x) {myCenterX = x;}
  public int  getX() {return (int)myCenterX;}
  public void setY(int y) {myCenterY = y;}
  public int  getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionY = x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
  public float getRadius() {return myRadius;}
}