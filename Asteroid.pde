
class Asteroid extends Floater {

  private int rotSpeed;
  private int myRadius;

  Asteroid() {
    myColor = color(103, 115, 125);
    myCenterX = Math.random() * 600;
    myCenterY = Math.random() * 400;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = Math.random() * 360;
    rotSpeed = (int)(Math.random() * 4 - 2);
    // System.out.println(rotSpeed);
    // hexagon asteroids
    corners = 6;
    int[] xS = { 6, 12,   6,  -6, -12, -6};
    int[] yS = {10,  0, -10, -10,   0, 10};
    xCorners = xS;
    yCorners = yS;
    myRadius = 10;
  }

  public void move() {
    rotate(rotSpeed);

    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;
    myCenterY += myDirectionY;

    //wrap around screen
    if (myCenterX > width + myRadius) {
      myCenterX = -myRadius;
    }
    else if (myCenterX < -myRadius) {
      myCenterX = width + myRadius;    
    }
    if (myCenterY > height + myRadius) {
      myCenterY = -myRadius;
    }
    else if (myCenterY < -myRadius) {
      myCenterY = height + myRadius;
    }
  }

  public void setX(int x) {myCenterX = x;}
  public int  getX() {return (int)myCenterX;}
  public void setY(int y) {myCenterY = y;}
  public int  getY() {return (int)myCenterY;}
  public void   setDirectionX(double x) {myPointDirection = x;}
  public double getDirectionX() {return myDirectionX;}
  public void   setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}
  public void   setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
  public int getRadius() {return myRadius;}
}