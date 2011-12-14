/*
 * Basic calibration tool for the arduino LED/LDR
 * colour sensor. Records mean raw values for
 * black and white samples.
 *
 * These values can be inserted directly into
 * defaultBlack and defaultWhite in other p5
 * sketches. 
 */

import processing.serial.*;
Serial arduinoPort;
PFont infoFont, consoleFont;

boolean isRunning;
color colour;
long intraTimer, extraTimer; 
float percent, total;
float[] values, latest, sums;

void setup() {
  size(800, 300);
  background(150);
  frameRate(60);
  smooth();
  infoFont = loadFont("infoFont.vlw");
  consoleFont = loadFont("consoleFont.vlw");
  
  connectToArduino();
  
  isRunning = false;
  
  values = new float[3];
  latest = new float[3];
  sums = new float[3];
  reset();
}

void draw() {
  background(150);
  
  if (isRunning) {
    if (total < 100.0) {
      if (millis() - intraTimer >= 500) {
        read();
        for (int i = 0; i < 3; i++) {
          values[i] = sums[i] / total;
        }
        colour = color(values[0], values[1], values[2]);
        intraTimer = millis();
      }
    }
    else {
      total = 100.0;
      isRunning = false;
    }
    int diff = int(millis() - extraTimer);
    percent = constrain(float(diff) / 508.0, 0.0, 100.0);
  }
  
  stroke(200);
  noFill();
  rect(50, 50, 550, 45);
  rect(620, 50, 130, 45);
  rect(50, 180, 130, 45);
  rect(200, 180, 130, 45);
  rect(350, 180, 130, 45);
  rect(500, 180, 130, 45);
  
  
  noStroke();
  
  fill(0, 150, 150);
  rect(51, 51, int((percent*5.49)+0.5), 44);
  
  if (isRunning) {
    fill(200, 140, 0);
  }
  if (mouseX > 620 && mouseX < 750) {
    if (mouseY > 50 && mouseY < 95) {
      rect(621, 51, 129, 44);
    }
  }
  
  noStroke();
  fill(200);
  textFont(infoFont);
  textAlign(CENTER);
  if (isRunning) {
    text("Restart", 685, 81);
  }
  else {
    text("Run", 685, 81);
  }
  text(int(percent+0.5) + "%", 325, 81);
  text(values[0], 115, 212);
  text(values[1], 265, 212);
  text(values[2], 415, 212);
  text(hex(colour, 6), 565, 212);
  
  textFont(consoleFont);
  textAlign(LEFT);
  text("Hold sample over sensor and click Run", 50, 125);
  textAlign(CENTER);
  text("Red", 50+65, 255);
  text("Green", 200+65, 255);
  text("Blue", 350+65, 255);
  text("Hex", 500+65, 255);
  
}

void mousePressed() {
  if (mouseX > 620 && mouseX < 750) {
    if (mouseY > 50 && mouseY < 95) {
      arduinoPort.write("read");
      reset();
      isRunning = true;
    }
  }
}

void connectToArduino() {
  int portNumber = -1;
  
  for (int i = 0; i < Serial.list().length; i++) {
    if (Serial.list()[i].equals("/dev/tty.usbmodemfd131")) {
      portNumber = i;
    }
  }
  
  if (portNumber >= 0) {
    String portName = Serial.list()[portNumber];
    arduinoPort = new Serial(this, portName, 9600);
  }
  else {
    exit();
  }
}

void reset() {
  total = 0;
  percent = 0.0;
  colour = color(0, 0, 0);
  
  for (int i = 0; i < 3; i++) {
    values[i] = 0.0;
    latest[i] = 0.0;
    sums[i] = 0.0;
  }
  
  intraTimer = millis();
  extraTimer = millis();
}

void read() {
  String received;
  
  if (arduinoPort.available() > 0) {
    received = String.valueOf(arduinoPort.readString());
    arduinoPort.clear();
    
    String[] splits = received.split(" ");
    latest[0] = Float.parseFloat(splits[0]);
    latest[1] = Float.parseFloat(splits[1]);
    latest[2] = Float.parseFloat(splits[2].substring(0, splits[2].length()-2));    //remove tailing space
    
    for (int i = 0; i < 3; i++) {
      sums[i] += latest[i];
      latest[i] = 0.0;
    }
    
    total += 1.0;
    arduinoPort.write("read");
  }
}
