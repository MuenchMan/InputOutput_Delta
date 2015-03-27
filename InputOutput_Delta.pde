// a piece of generative Art called Delta
// author: @MuenchMan
// license: The MIT License (MIT)
// created during a course on the University of Applied Science Potsdam
// many thanks to @fabiantheblind for sharing his knowledge!

int screenWidth = 500;
int screenHeight = 500;
int screenMiddleX = screenWidth/2;
int screenMiddleY = screenHeight/2;
int screenPercX = screenWidth/100;
int screenPercY = screenHeight/100;

class Point {  // Class for the Point-Object that I use to store the position
  float xPos;
  float yPos;
  int randomizeItX;  // randomizer-value for x axis
  int randomizeItY;  // randomizer-value for y axis

  Point(float tempxPos, float tempyPos) {
    xPos = tempxPos;
    yPos = tempyPos;
    randomizeItX = 0;  // randomizer-value for x axis
    randomizeItY = 0;  // randomizer-value for y axis
  }

  void displayPoint() {  //use to display the points
    stroke(0, 250, 154);              
    strokeWeight(6);
    point (xPos, yPos);
  }

  int getClosestPoint() {  // finds closest Point below the current point
    float tempDistance = 999999; // starting value has to be bigger than possible range of distance
    float distClosest = 999999;  // starting value has to be bigger than possible range of distance
    int theClosestPoint = 0;    
    randomizeItX = (int) random(0, 50); // change values to change x axis randomization
    randomizeItY = (int) random(0, 50);  // change values to change y axis randomization -  !INTERESTING!
    for (int i = 0; i<numPoints; i++) {
      tempDistance = dist(xPos, yPos, points[i].xPos+randomizeItX, points[i].yPos);  // calculates distance between point and all points in the array
      if ((tempDistance < distClosest) && (tempDistance > 0) && (points[i].yPos>yPos)) {  // rules out: same point, points above, points further away
        distClosest = tempDistance; 
        theClosestPoint = i;  // sets this point as closest point
      }
    }
    return theClosestPoint;  // returns closest point
  }
}

int numPoints = 60; // number of total points  -  !INTERESTING!
Point[] points = new Point[numPoints];   // declares and creates array

void setup() {    // setup-area -------------------
  // printArray (points);
  size (screenWidth, screenHeight);
  noLoop();  // stops draw-looping - COMMENT - if you want to save images
  background(20);
} // setup end bracket


void draw() {    // draw-area -------------------

  background(20);  // clears the screen from previous image

  //  creates half of the  points in the upper half of the screen
  for (int i=0; i<numPoints/2; i++) {             
    int randomX = round(randomGaussian()*200)+screenMiddleX; 
    int randomY = (int) random(0, screenMiddleY);

    if (randomY<0) {         
      randomY = randomY * -1; // turns negative into positive numbers
    }

    if (randomX<0) {                    
      randomX = randomX * -1; // turns negative into positive numbers
    }

    if (randomX>screenWidth) {
      int r = (int) random(1, screenPercX*20); // creates random integer
      randomX = screenWidth-r; // bounces numbers > than screenWidth below screenWidth
    } 
    points[i] = new Point(randomX, randomY); // creates a Point object within the points array with the calculated position
  }

  //  creates half of the points in the middle vertical third of the screen
  for (int i=numPoints/2; i< (numPoints/2)*2; i++) {            
    int randomX = round(random(screenPercX*30, screenPercX*70));
    int randomY = round(randomGaussian()*200);

    if (randomY<0) {  // turns negative into positive numbers
      randomY = randomY * -1;
    }

    if (randomY>screenHeight) {
      int r = (int) random(1, screenPercY*20); // creates random integer
      randomY = screenHeight-r; // bounces numbers > than screenHeight below screenHeight
      println("intruder alert!" + randomY); //prints positions that break the boundaries
    }
    points[i] = new Point(randomX, randomY); // creates a Point object within the points array with the calculated position
  }

  int lineCounter = 600 ;  // change for number of lines  -  !INTERESTING!
  for (int e = 0; e < lineCounter; e++) {  
    float startPosX = random(0, screenWidth); //random start x position
    float startPosY = 0;
    float endPosX = 250;  // endposition
    float endPosY = 500;  // endposition
    Point startPoint = new Point(startPosX, startPosY); // creates a Point object with the startvalues
    int lastPoint = 0;  
    float lastPosX = startPosX;
    float lastPosY = startPosY;
    float lowestPos = 0;
    int closestBelow = startPoint.getClosestPoint(); // gets closest Point to starting Point

      for (int i = 0; i < lineCounter; i++) { // draws lines and checks for closest point below
      closestBelow = points[closestBelow].getClosestPoint();
      float newPosX = points[closestBelow].xPos;
      float newPosY = points[closestBelow].yPos;
      if (newPosY < lowestPos) {
        newPosX = endPosX;
        newPosY = endPosY;
        i = lineCounter+1;  // stops the loop
      }
      stroke(255, 250, 250, 5); // line color
      strokeWeight(1);  // line thickness
      line(lastPosX, lastPosY, newPosX, newPosY); // draws the line
      lastPosX = newPosX;
      lastPosY = newPosY;
      lowestPos = newPosY;
      println(lastPosX);
    }
  }

  // Saves each frame as line-000001.png, line-000002.png, etc.
  // saveFrame("line-######.png"); // UNCOMMENT - if you want to save images
} // draw end bracket

