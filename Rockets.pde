class Rockets extends Floater {

  Rockets() {
    myColor = color(255, 255, 255);
    myCenterX = Math.random() * 600;
    myCenterY = Math.random() * 400;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }

  Rockets(int spaceShipX, int spaceShipY, double spaceShipDirX, double spaceShipDirY, double spaceShipPointDir) {
    myColor = color(255, 255, 255);
    myCenterX = spaceShipX;
    myCenterY = spaceShipY;
    myDirectionX = spaceShipDirX;
    myDirectionY = spaceShipDirY;
    myPointDirection = spaceShipPointDir;

    corners = 8;
    int[] xS = { 0, -10, -4, -11, -5, -10, 8, 0};
    int[] yS = { 0,   3,  0,   0, -1,  -3, 0, 0};
    xCorners = xS;
    yCorners = yS;
  }
  //Draws the floater at the current position
  //Same as Floater but beginShape(LINES)
  public void show() {
    fill(myColor);
    stroke(myColor);
    strokeWeight(2);
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);          
    int xRotatedTranslated, yRotatedTranslated;
    beginShape(LINES);
    for(int nI = 0; nI < corners; nI++) {
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);
      vertex(xRotatedTranslated,yRotatedTranslated);
    }
    endShape(CLOSE);
    noStroke();
  }

  public void setX(int x) {myCenterX = x;}
  public int  getX() {return (int)myCenterX;}
  public void setY(int y) {myCenterY = y;}
  public int  getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myPointDirection = x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
}
