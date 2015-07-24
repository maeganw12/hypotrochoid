float shortR, longR, angle, d;
PVector planet;

int numberOfPlanets = 10;
int numberOfProperties = 8;
float[] planetProperties;

float time =  20000;
float timeMemory = millis();

boolean planetMode = false;

void setup()
{
  frame.setResizable(true);

  size(displayHeight, displayHeight);
  frameRate(1000);  

  angle = 0;

  d = 50;


  planetProperties = new float[numberOfPlanets * numberOfProperties];

  initNumbers();
}

void initNumbers()
{
  //(float lR, float sR, float angle, float r, float g, float b, float size, float angleIncrement) 
  for (int i = 0; i < numberOfProperties * numberOfPlanets; i += numberOfProperties)
  {
    planetProperties[i + 1]  =  random(0, width/2);
    planetProperties[i]      =  random( planetProperties[i + 1], width/3 * 2);

    planetProperties[i + 2]  =  random(150, 200);
    planetProperties[i + 3]  =  random(150, 200);
    planetProperties[i + 4]  =  random(190, 200);
    planetProperties[i + 5]  =  random(0.01, 1); 

    planetProperties[i + 6]  = random(0, TWO_PI);
    planetProperties[i + 7]  = random(0.5, 5);
  }

  println(planetProperties);

  background(20, 20, 20);
}

void keyPressed()
{
  initNumbers();
}

void mousePressed()
{

  initNumbers();
  //saveFrame("pics/hypo-######.png");

  planetMode = !planetMode;
}

void draw()
{
  angle += 0.01;

  fill(60, 0.1);
  rect(0, 0, width, height);

  if (planetMode) {
    background(0);
  }

  for (int i = 0; i <  numberOfPlanets; i += 1)
  {
    float lR = planetProperties[i * numberOfProperties];
    float sR = planetProperties[i * numberOfProperties + 1];
    float r = planetProperties[i * numberOfProperties + 2];
    float g = planetProperties[i * numberOfProperties + 3];
    float b = planetProperties[i * numberOfProperties + 4];
    float size = planetProperties[i * numberOfProperties + 5];
    float angle = planetProperties[i * numberOfProperties + 6];
    float angleIncrement = planetProperties[i * numberOfProperties + 7];

    if (planetMode) {
      planetProperties[i * numberOfProperties + 6] = planetMode(lR, sR, angle, r, g, b, size, angleIncrement);
    } else {
      planetProperties[i * numberOfProperties + 6] = hypotrochoidEquation(lR, sR, angle, r, g, b, size, angleIncrement);

      for (float j = 0; j < TWO_PI; j += 0.1) {
        float empty = hypotrochoidEquation(lR, sR, angle + j, r, g, b, size, angleIncrement);
      }
    }
  } 


  //center();


  //saveFrame("pics/hypo-######.png");

  if ( timeMemory + time < millis() && !planetMode ) {
    initNumbers();

    timeMemory = millis();
  }
}

void center()
{
  pushMatrix();
  translate(width/2, height/2);
  fill(50);
  stroke(0);
  sphere(50);
  //ellipse(0, 0, 50, 50);

  //sphere(30);
  popMatrix();
}

float hypotrochoidEquation(float lR, float sR, float angle, float r, float g, float b, float size, float angleIncrement)
{

  float xPlanet = (lR - sR) * cos(angle) + d * cos((lR - sR)/(sR) * angle);
  float yPlanet = (lR - sR) * sin(angle) - d * sin((lR - sR)/(sR) * angle);

  PVector result = new PVector(xPlanet, yPlanet);

  angle += angleIncrement;

  pushMatrix();
  translate(result.x + width/2, result.y + height/2);
  fill(r, r, r, b);
  stroke(r, r, r, b);
  ellipse(0, 0, size, size);
  popMatrix();

  return angle;
}


float planetMode(float lR, float sR, float angle, float r, float g, float b, float size, float angleIncrement)
{

  float xPlanet = (lR - sR) * cos(angle) + d * cos((lR - sR)/(sR) * angle);
  float yPlanet = (lR - sR) * sin(angle) - d * sin((lR - sR)/(sR) * angle);

  PVector result = new PVector(xPlanet, yPlanet);

  angle += angleIncrement/500;

  pushMatrix();

  translate(result.x + width/2, result.y + height/2);
  fill(r, g, b);
  stroke(r, g, b);
  ellipse(0, 0, size * 20, size * 20);
  popMatrix();

  return angle;
}

