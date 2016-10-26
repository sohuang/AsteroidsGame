SpaceShip spaceship;
Star star;

public void setup() {
  size(600, 400);
  background(15, 25, 50);
  spaceship = new SpaceShip();
  star = new Star();
}
public void draw() {
  background(15, 25, 50);
  spaceship.move();
  spaceship.show();
  star.move();
  star.show();
}
public void keyPressed() {
  if (keyCode == LEFT  || key == 'a' || key == 'A') {
    // rotate left
    spaceship.rotate(-10);
  }
  if (keyCode == RIGHT || key == 'd' || key == 'D') {
    // rotate right
    spaceship.rotate(10);
  }
  if (keyCode == UP    || key == 'w' || key == 'W') {
    // accelerate forward
    spaceship.accelerate(0.75);
  }
  if (keyCode == DOWN  || key == 's' || key == 'S') {
    // accelerate backward
    spaceship.accelerate(-0.75);
  }
  if (key == ' ') {
    // hyperspace
    spaceship.setX((int)(Math.random() * 600));
    spaceship.setY((int)(Math.random() * 400));
    spaceship.setDirectionX(0);
    spaceship.setDirectionY(0);
    spaceship.setPointDirection((int)(Math.random() * 360));
  }
}
class SpaceShip extends Floater {

  SpaceShip() {
    myStrokeColor = myFillColor = color(255, 255, 255);
    myCenterX = Math.random() * 600;
    myCenterY = Math.random() * 400;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
    // triangle thing
    corners = 4;
    int[] xS = {-6,  9, -6, -3};
    int[] yS = { 6,  0, -6,  0};
    xCorners = xS;
    yCorners = yS;
  }

  public void setX(int x) {myCenterX = x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y) {myCenterY = y;}
  public int getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
}

class Star extends Floater {

  Star() {
    myFillColor = color(255, 255, 255);
    myStrokeColor = color(255, 255, 255);
    myCenterX = Math.random() * 600;
    myCenterY = Math.random() * 400;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = Math.random() * 360;

    // pointy star
    corners = 8;
    int[] xS = {0, 1, 4,  1,  0, -1, -4, -1};
    int[] yS = {4, 1, 0, -1, -4, -1,  0,  1};

    // hexagon stars
    // corners = 6;
    // int[] xS = {3, 6,  3, -3, -6, -3};
    // int[] yS = {5, 0, -5, -5,  0,  5};

    // actual star shape
    // corners = 10;
    // int[] xS = { -6, -24, -12, -24,  -6,   5,   5,  24,   5,   5};
    // int[] yS = {  9,  16,   0, -16,  -9, -24,  -6,   0,   6,  24};

    xCorners = xS;
    yCorners = yS;
  }

  public void setX(int x) {myCenterX = x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y) {myCenterY = y;}
  public int getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
}

//Do NOT modify the Floater class! Make changes in the SpaceShip class 
abstract class Floater {
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;
  protected int[] yCorners;
  protected color myStrokeColor, myFillColor;
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);
  abstract public int getX();
  abstract public void setY(int y);
  abstract public int getY();
  abstract public void setDirectionX(double x);
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);
  abstract public double getDirectionY();
  abstract public void setPointDirection(int degrees);
  abstract public double getPointDirection();

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate(double dAmount) {
    //convert the current direction the floater is pointing to radians
    double dRadians = myPointDirection*(Math.PI/180);
    //change coordinates of direction of travel
    myDirectionX += ((dAmount) * Math.cos(dRadians));
    myDirectionY += ((dAmount) * Math.sin(dRadians));
  }
  public void rotate(int nDegreesOfRotation) {
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;
  }
  //move the floater in the current direction of travel
  public void move() {
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;
    myCenterY += myDirectionY;

    //wrap around screen
    if (myCenterX > width) {
      myCenterX = 0;
    }
    else if (myCenterX < 0) {
      myCenterX = width;    
    }
    if (myCenterY > height) {
      myCenterY = 0;
    }
    else if (myCenterY < 0) {
      myCenterY = height;
    }
  }
  //Draws the floater at the current position
  public void show() {
    fill(myFillColor);
    stroke(myStrokeColor);
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);          
    int xRotatedTranslated, yRotatedTranslated;
    beginShape();
    for(int nI = 0; nI < corners; nI++) {
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);
      vertex(xRotatedTranslated,yRotatedTranslated);
    }
    endShape(CLOSE);
  }
}