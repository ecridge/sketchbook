PImage bg;
PFont font;

final float vIn = 9.0;
final float rLoad = 3000f;
final float kelvin = 273.15;
final float a = 1.40e-3;
final float b = 2.37e-4;
final float c = 9.90e-8;

float tempC = 25.0;
float tempK = tempC + kelvin;
float rTherm, vOut;

void setup() {
  size(603, 412);
  frameRate(60);
  smooth();
  noStroke();

  bg = loadImage("bg.png");
  font = loadFont("textFont.vlw");
  textFont(font);

  background(bg);
}

void draw() {
  background(bg);
  int value = (height - mouseY);
  value = constrain(value, 60, height-60);
  tempC = ( (value-60.0) / (height-120) ) * 150.0;
  tempK = tempC + kelvin;
  
  rTherm = calculateResistance(tempK);
  vOut = vIn * ( rLoad / (rLoad + rTherm) );

  fill(0);
  textAlign(RIGHT);
  text(String.format("%.1f", vIn) + "V", 50, 50);
  text(String.format("%.1f", rLoad/1000.0) + "kΩ", 270, 310);
  
  fill(200, 0, 0);
  text(round(tempC) + "ºC", width - 10, 20);
  ellipse(width - 20, height - 20, 20, 20);
  rect(width - 23, height - 20, 6, -40 - (tempC/150.0)*300);
  
  fill(0, 200, 0);
  text(String.format("%.1f", rTherm/1000.0) + "kΩ", 270, 120);
  ellipse(width - 45, height - 20, 20, 20);
  rect(width - 48, height - 20, 6, -40 - (rTherm/10000.0)*300);
  
  fill(0, 0, 200);
  text(String.format("%.1f", vOut) + "V", 490, 310);
  ellipse(width - 70, height - 20, 20, 20);
  rect(width - 73, height - 20, 6, -40 - (vOut/8.8)*300);
}

float calculateResistance(float temp) {
  float r = (a - 1.0/temp) / c;
  float s = sqrt( pow(b / (3*c), 3) + pow(r, 2)/4.0 );
  float resistance = exp( pow(s - r/2.0, 1/3.0) - pow(s + r/2.0, 1/3.0) );
  return resistance;
}
