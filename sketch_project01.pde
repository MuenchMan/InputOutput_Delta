int screenWidth = 500;
int screenHeight = 500;
int screenMiddleX = screenWidth/2;
int screenMiddleY = screenHeight/2;
int screenPercX = screenWidth/100;
int screenPercY = screenHeight/100;

IntList randomPoints;


void setup() {
  size (screenWidth, screenHeight);
  noLoop();
  randomPoints = new IntList();
  background(51);
}

void draw() {


  //  -------------------------------------creates 20 random points in the upper half of the screen
  for (int i=1; i<20; i++) {             
    int randomX = round(randomGaussian()*200)+screenMiddleX;
    int randomY = (int) random(0, screenMiddleY);

    if (randomY<0) {                    // turns negative into positive numbers
      randomY = randomY * -1;
    }

    if (randomX<0) {                    // turns negative into positive numbers
      randomX = randomX * -1;
    }

    stroke(0, 250, 154);
    strokeWeight(2);
    point (randomX, randomY);
    randomPoints.append(randomX);      // adds coordinates to randomPoints FloatList
    randomPoints.append(randomY);
  }


  //  -------------------------------------creates 20 random points in the middle vertical third of the screen
  for (int i=1; i<20; i++) {            
    int randomX = round(random(screenPercX*30, screenPercX*70));
    int randomY = round(randomGaussian()*200);

    if (randomY<0) {                    // turns negative into positive numbers
      randomY = randomY * -1;
    }

    if (randomY>screenHeight) {
      int r = (int) random(1, screenPercY*20);        // creates random integer
      randomY = screenHeight-r;        // bounces numbers > than screenHeight below screenHeight
      println("intruder alert!" + randomY);
    }

    randomPoints.append(randomX);      // adds coordinates to randomPoints FloatList
    randomPoints.append(randomY); 
    stroke(255, 69, 0);
    strokeWeight(2);
    point (randomX, randomY);
  }

  println(randomPoints);              // print randomPoints arrayList
}

