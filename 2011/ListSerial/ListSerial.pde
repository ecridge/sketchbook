/* 
 * Displays a list of available serial ports.
 */
 
import processing.serial.*;

PFont font;

void setup() {
  size(400, 300);
  frameRate(10);
  noStroke();
  background(89, 135, 209);
  smooth();
  fill(255);
  
  font = loadFont("Menlo-Regular-12.vlw");
  textFont(font);
  textAlign(LEFT);
}

void draw() {
  background(89, 135, 209);
  text("Printout of Serial.list():", 10, 18);
  for (int i = 0; i < 14; i++) {
    if (i < Serial.list().length) {
      text("[" + i + "]: " + Serial.list()[i], 10, 18*(i+2));
    }
  }
  
  text("(Refreshes automatically)", 10, 288);
}
