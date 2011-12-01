/* 
 * Calculates the byte value to shift out in order to
 * display a certain digit on a 7- or 8-segment display.
 * 
 * Order of segments is taken from top left to bottom right.
 *
 */
 
final int[] shiftOutOrder = { 8, 7, 6, 5, 1, 4, 2, 3 };

int[] segmentValue = new int[8];

Segment[] segments = new Segment[8];
PFont infoFont;
int byteValue;

void setup() {
  size(400, 600);
  background(10);
  smooth();
  noStroke();
  fill(50, 0, 0);
  infoFont = loadFont("infoFont.vlw");
  textFont(infoFont);
  textAlign(CENTER);
  
  byteValue = 0;
  for (int i = 0; i < 8; i++) segmentValue[i] = 128 >> shiftOutOrder[i]-1;
  
  segments[0] = new Segment(40, 0, 160, 40);
  segments[1] = new Segment(0, 40, 40, 160);
  segments[2] = new Segment(200, 40, 40, 160);
  segments[3] = new Segment(40, 200, 160, 40);
  segments[4] = new Segment(0, 240, 40, 160);
  segments[5] = new Segment(200, 240, 40, 160);
  segments[6] = new Segment(40, 400, 160, 40);
  segments[7] = new Segment(240, 400, 40, 40);
}

void draw() {
  background(10);
  pushMatrix();
    translate(80, 50);
    for (int i = 0; i < 8; i++) segments[i].display();
  popMatrix();
  
  fill(255);
  text("Shift out: " + byteValue, 200, 570);
}

void mousePressed() {
  for (int i = 0; i < 8; i++) segments[i].update(mouseX-80, mouseY-50);
  
  byteValue = 0;
  for (int i = 0; i < 8; i++) byteValue += segments[i].isOn * segmentValue[i];
}
