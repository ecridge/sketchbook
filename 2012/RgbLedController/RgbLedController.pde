//RGB LED Serial controller

import processing.serial.*;

Serial arduinoPort;

int r, g, b;

void setup() {
  size(720, 240);
  background(255);
  frameRate(9);        //frameRate must be <10 so that data is sent less frequently that 100ms buffer fill time (or messages will overlap)
  noStroke();
  
  String portName = Serial.list()[6];    //Use ListSerial.app to find port number
  arduinoPort = new Serial(this, portName, 9600);
  
  r = 0;
  g = 0;
  b = 0;
  
  for(int i = 0; i < 360; i++) {
    //drawRed(i, height-12, 4);
    //drawGreen(i, height-8, 4);
    //drawBlue(i, height-4, 4);
    drawSpectrum(i, 0, height);
  }
}

void draw() {
  float mouseDegree = mouseX*(360.0/width);
  r = calculateRed(int(mouseDegree));
  g = calculateGreen(int(mouseDegree));
  b = calculateBlue(int(mouseDegree));
  
  String stringToSend = "r" + r + " g" + g + " b" + b;
  arduinoPort.write(stringToSend);
}

void mousePressed() {
  println("RGB(" + r + ", " + g + ", " + b + ")");
}

void drawRed(int degree, int bandTop, int bandWidth) {
  int redBrightness = calculateRed(degree);
  fill(redBrightness, 0, 0);
  rect(degree*2, bandTop, 2, bandWidth);
}

void drawGreen(int degree, int bandTop, int bandWidth) {
  int greenBrightness = calculateGreen(degree);
  fill(0, greenBrightness, 0);
  rect(degree*2, bandTop, 2, bandWidth);
}

void drawBlue(int degree, int bandTop, int bandWidth) {
  int blueBrightness = calculateBlue(degree);
  fill(0, 0, blueBrightness);
  rect(degree*2, bandTop, 2, bandWidth);
}

void drawSpectrum(int degree, int bandTop, int bandWidth) {
  fill( calculateRed(degree) , calculateGreen(degree) , calculateBlue(degree) );
  rect(degree*2, bandTop, 2, bandWidth);
}

int calculateRed(int degree) {
  float brightness;
  if (degree < 60 || (degree >= 300 && degree < 360)) brightness = 255.0;
  else if (degree >= 60 && degree < 120) brightness = 255.0 - (((degree-60.0)/60.0)*255.0);
  else if (degree >= 240 && degree < 300) brightness = ((degree-240.0)/60.0)*255.0;
  else brightness = 0.0;
  return int(brightness);
}

int calculateGreen(int degree) {
  float brightness;
  if (degree >= 0 && degree < 60) brightness = (degree/60.0)*255.0;
  else if (degree >= 60 && degree < 180) brightness = 255.0;
  else if (degree >= 180 && degree < 240) brightness = 255.0 - (((degree-180.0)/60.0)*255.0);
  else brightness = 0.0;
  return int(brightness);
}

int calculateBlue(int degree) {
  float brightness;
  if (degree >= 120 && degree < 180) brightness = ((degree-120.0)/60.0)*255.0;
  else if (degree >= 180 && degree < 300) brightness = 255.0;
  else if (degree >= 300 && degree < 360) brightness = 255.0 - (((degree-300.0)/60.0)*255.0);
  else brightness = 0.0;
  return int(brightness);
}
