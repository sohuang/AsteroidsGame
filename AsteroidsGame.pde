PFont space_mono;
SpaceShip spaceship;
Rockets rockets;
Star[] stars;
int numStars = 80;
ArrayList<Asteroid> asteroids;
int numAsteroids = 10;
ArrayList<Bullet> bullets;
Bullet bullet;
int score;

public void setup() {
  size(600, 400);
  background(0, 25, 50);
  space_mono = createFont("SpaceMono-Regular.ttf", 32);
  // noCursor();
  noStroke();
  spaceship = new SpaceShip();
  rockets = new Rockets(spaceship.getX(), spaceship.getY(), spaceship.getDirectionX(), spaceship.getDirectionY(), spaceship.getPointDirection());
  stars = new Star[numStars];
  for (int i = 0; i < numStars; i++) {
    stars[i] = new Star();
  }
  asteroids = new ArrayList<Asteroid>();
  for (int i = 0; i < numAsteroids; i++) {
    asteroids.add(new Asteroid());
    asteroids.get(i).accelerate(Math.random() * 0.3);    
  }
  bullets = new ArrayList<Bullet>();
  bullet = new Bullet(spaceship);
  score = 0;
}

public void draw() {
  background(0, 25, 50);
  for (int i = 0; i < numStars; i++) {
    stars[i].show();
  }

  stroke(255);
  textFont(space_mono);
  textSize(16);
  String formatter = "";
  if (score < 100) {
    formatter = " 0";
  }
  if (score < 10) {
    formatter = " 00";
  }
  if (score < 0) {
    formatter = "-00";
  }
  if (score < -9) {
    formatter = "-0";
  }
  if (score < -99) {
    formatter = "-";
  }
  text("Score: " + formatter + Math.abs(score), width - 120, 20);
  noStroke();

  // background(15, 25, 50, 0.1);
  spaceship.move();
  rockets.move();
  spaceship.show();
  
  for (int i = 0; i < asteroids.size(); i++) {
    asteroids.get(i).show();
    asteroids.get(i).rotate(1);
    asteroids.get(i).move();
  }
  for (int i = asteroids.size() - 1; i >= 0; i--) {
    if (dist(spaceship.getX(), spaceship.getY(), asteroids.get(i).getX(), asteroids.get(i).getY()) <= 16) {
      asteroids.remove(i);
      score -= 10;
    }
  }
  if (bullets != null) {
    for (int i = bullets.size() - 1; i >= 0; i--) {
      bullets.get(i).show();
      bullets.get(i).move();
      if (bullets.get(i).getX() >= width + bullets.get(i).getRadius() || bullets.get(i).getX() <= 0 - bullets.get(i).getRadius() || bullets.get(i).getY() >= height + bullets.get(i).getRadius() || bullets.get(i).getY() <= 0 - bullets.get(i).getRadius()) {
        bullets.remove(bullets.get(i));
      }
    }
  }
  for (int i = bullets.size() - 1; i >= 0; i--) {
    for (int j = asteroids.size() - 1; j >= 0; j--) {
      if (bullets != null && asteroids != null) {
        if (dist(bullets.get(i).getX(), bullets.get(i).getY(), asteroids.get(j).getX(), asteroids.get(j).getY()) <= (bullets.get(i).getRadius() + asteroids.get(j).getRadius())) {
          bullets.remove(bullets.get(i));
          asteroids.remove(asteroids.get(j));
          score += 50;
          break;
        }
      }
    }
  }
  int countA = 1; int countB = 2;
}

public void keyPressed() {
  if (key == ENTER) {
    // hyperspace
    spaceship.setX((int)(Math.random() * 600));
    spaceship.setY((int)(Math.random() * 400));
    spaceship.setDirectionX(0);
    spaceship.setDirectionY(0);
    spaceship.setPointDirection((int)(Math.random() * 360));
    rockets = new Rockets(spaceship.getX(), spaceship.getY(), spaceship.getDirectionX(), spaceship.getDirectionY(), spaceship.getPointDirection());
  } else {
    if (keyCode == LEFT  || key == 'a' || key == 'A') {
      // rotate left
      spaceship.rotate(-10);
      rockets.rotate(-10);
    }
    if (keyCode == RIGHT || key == 'd' || key == 'D') {
      // rotate right
      spaceship.rotate(10);
      rockets.rotate(10);
    }
    if (keyCode == UP    || key == 'w' || key == 'W') {
      // accelerate forward
      spaceship.accelerate(0.5);
      rockets.accelerate(0.5);
      rockets.show();
    }
    if (keyCode == DOWN  || key == 's' || key == 'S') {
      // accelerate backward
      spaceship.accelerate(-0.5);
      rockets.accelerate(-0.5);
      rockets.show();
    }
    if (key == ' ') {
      // shoot
      Bullet b = new Bullet(spaceship);
      bullets.add(b);
    }
  }
}

class SpaceShip extends Floater {

  SpaceShip() {
    myColor = color(255, 255, 255);
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
    int[] xS = {-5, -10, -4, -11, -5, -10, 8, 0};
    int[] yS = { 1,   3,  0,   0, -1,  -3, 0, 0};
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

//Do NOT modify the Floater class! Make changes in the SpaceShip class 
abstract class Floater {
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;
  protected int[] yCorners;
  protected color myColor;
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
    fill(myColor);
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