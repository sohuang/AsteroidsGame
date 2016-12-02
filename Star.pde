class Star extends Floater {

  private boolean shapeChooser;

  Star() {
    shapeChooser = Math.random() < 0.5;
    
    // myColor = color(0, 50, 100);
    myColor = color(163, 181, 194);
    myCenterX = Math.random() * 600;
    myCenterY = Math.random() * 400;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = Math.random() * 360;

    // pointy star
    corners = 8;
    int[] xS = {0, 1, 4,  1,  0, -1, -4, -1};
    int[] yS = {4, 1, 0, -1, -4, -1,  0,  1};

    // actual star shape
    // corners = 10;
    // int[] xS = { -6, -24, -12, -24,  -6,   5,   5,  24,   5,   5};
    // int[] yS = {  9,  16,   0, -16,  -9, -24,  -6,   0,   6,  24};

    xCorners = xS;
    yCorners = yS;
  }

  public void show() {
    if (shapeChooser) {
      super.show();
    } else {
      fill(255);
      ellipse((int)myCenterX, (int)myCenterY, 1.5, 1.5);
    }
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