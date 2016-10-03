/* 
 * Reads the raw input from arduino RGB/LDR colour
 * sensor (0-255 uncalibrated).
 *
 * Program adjusts input and draws colour to screen.
 * Calculated hue is also drawn, though this should
 * be ignored as brightness approaches 0 or 100%,
 * at which point it is technically undefined.
 *
 * This is used to sort jigsaw puzzle pieces into
 * different colours in cooperation with an NXT
 * running JigSorterClient.nxj (Start NXT first!).
 */

import processing.serial.*;
Serial arduinoPort, nxtPort;

ColourSensorReader reader; 
CategoryViewer categoryViewer;
Console console;
Overview overview;

PFont infoFont, consoleFont;
color defaultBlack, defaultWhite;
float unsortedThreshold, whiteThreshold;
final int RED = 0;
final int YELLOW = 1;
final int GREEN = 2;
final int BLUE = 3;
final int WHITE = 4;
final int UNSORTED = 5;
final String[] names = { 
  "Red", "Yellow", "Green", "Blue", "White", "Unsorted"
};

int nextCategory, count;

void setup() {
  size(1280, 800);
  background(150);
  frameRate(15);
  smooth();
  infoFont = loadFont("infoFont.vlw");
  consoleFont = loadFont("consoleFont.vlw");

  connectToArduino();
  connectToNxt();

  defaultBlack = color(39.00, 22.00, 15.00);
  defaultWhite = color(75.99, 40.36, 24.62);
  unsortedThreshold = 50.0;
  whiteThreshold = 200.0;

  reader = new ColourSensorReader(arduinoPort, defaultBlack, defaultWhite, infoFont);
  categoryViewer = new CategoryViewer();
  console = new Console(consoleFont);
  overview = new Overview(infoFont);

  console.pushNewLine("Click to focus colour sensor...");
  count = -1;
}

void draw() {
  background(150);

  noStroke();
  fill(0);
  textFont(infoFont);
  textAlign(LEFT);
  text("Sensor Reading", 20, 45);
  text("Categorisation", 20, 345);
  text("Console", 640, 45);
  text("Overview", 640, 545);

  pushMatrix();
  translate(20, 60);
  reader.displayReading();
  translate(0, 300);
  categoryViewer.display();
  translate(620, -300);
  console.display();
  translate(0, 500);
  overview.display();
  popMatrix();
}

void mousePressed() {
  reader.read();
  nextCategory = categoryViewer.chooseCategory(reader.getHue(), reader.getBrightness());
  categoryViewer.setSelected(nextCategory);

  nxtPort.write(nextCategory);

  if (count == -1) { 
    console.appendCurrentLine("SUCCESS");
    console.pushNewLine("Click again to focus sorter...");
  }
  else if (count == 0) {
    console.appendCurrentLine("SUCCESS");
    console.pushNewLine("First scan on next click...");
  }
  else {
    console.appendCurrentLine("DONE");
    console.pushNewLine("Piece " + count + ": " + names[nextCategory]);
    
    overview.incrementCatCount(nextCategory);
    overview.incrementNTotal();
  }

  count++;
}

void keyPressed() {
  if (key == 'f' || key == 'F') {
    nextCategory = int(random(6));
    categoryViewer.setSelected(nextCategory);

    nxtPort.write(nextCategory);

    if (count == -1) { 
      console.appendCurrentLine("SUCCESS");
      console.pushNewLine("Click again to focus sorter...");
    }
    else if (count == 0) {
      console.appendCurrentLine("SUCCESS");
      console.pushNewLine("First scan on next click...");
    }
    else {
      if (count != 1) {
        console.appendCurrentLine("DONE");
      }
      
      console.pushNewLine("Piece " + count + ": " + names[nextCategory]);
    
      overview.incrementCatCount(nextCategory);
      overview.incrementNTotal();
    }

    count++;
  }
}

void connectToArduino() {
  int serialPort = -1;
  for (int i = 0; i < Serial.list().length; i++) {
    if (Serial.list()[i].equals("/dev/tty.usbmodemfd131")) {
      serialPort = i;
    }
  }
  if (serialPort >= 0) {
    String portName = Serial.list()[serialPort];    //Use ListSerial.app to find port number manually
    arduinoPort = new Serial(this, portName, 9600);
  }
  else {
    exit();
  }
}

void connectToNxt() {                                      //Must pair with computer first
  int serialPort = -1;
  for (int i = 0; i < Serial.list().length; i++) {
    if (Serial.list()[i].equals("/dev/tty.Joe-DevB")) {    //NXT's device name should be .:Joe:. and BT passcode 1234
      serialPort = i;
    }
  }
  if (serialPort >= 0) {
    String portName = Serial.list()[serialPort];
    nxtPort = new Serial(this, portName, 9600);
  }
  else {
    exit();
  }
}
