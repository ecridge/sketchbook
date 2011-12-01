class Segment {
  int x, y, xSize, ySize;
  int isOn;
  
  Segment(int x_, int y_, int xSize_, int ySize_) {
    x = x_;
    y = y_;
    xSize = xSize_;
    ySize = ySize_;
    isOn = 0;
  }
  
  void display() {
    if (isOn == 1) fill(150, 0, 0);
    else fill(50, 0, 0);
    
    rect(x, y, xSize, ySize);
  }
  
  void update(int clickX, int clickY) {
    if (clickX >= x && clickX <= x + xSize) {
      if (clickY >= y && clickY <= y + ySize) isOn ^= 1;    //^=1 is the same as ~
    }
  }
}
