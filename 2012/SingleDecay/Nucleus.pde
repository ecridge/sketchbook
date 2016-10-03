/*
 * A Nucleus is a coloured circle object which
 * has a grid coordinate and decay state.
 */

class Nucleus {
  int xCoord, yCoord;
  boolean isStable;
  color stableColor = color(0, 200, 240);
  color unstableColor = color(200, 0, 200);
  
  Nucleus(int xCoord_, int yCoord_) {
    xCoord = xCoord_;
    yCoord = yCoord_;
    isStable = false;
  }
  
  void update() {
    if (!isStable) {
      int r = (int) random(20);
      if (r == 0) isStable = true;
    }
  }
  
  void display() {
    noStroke();
    if (isStable) fill(stableColor);
    else fill(unstableColor);
    
    ellipse(xCoord*15, yCoord*15, 10, 10);
  }
}
