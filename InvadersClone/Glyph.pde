class Glyph {
  int absXPos, absYPos;
  color c;
  color[][] fillMapping;
  boolean isVisible = false;
  
  Glyph(int gridX, int gridY, color c_) {
    absXPos = gridX * glyphWidth;    // x and y positions refer to top left corner starting (0, 0)
    absYPos = gridY * glyphWidth;
    c = c_;
    fillMapping = new color[5][5];
    
    for (int i = 0; i < 3; i++) {    //left side
      for (int j = 0; j < 5; j++) {
        int r = (int) random(2);
        if (r == 1) fillMapping[i][j] = c;
        else fillMapping[i][j] = color(255, 0);
      }
    }
    
    for (int i = 3; i < 5; i++) {    //reflect to create right side
      for (int j = 0; j < 5; j++) {
        fillMapping[i][j] = fillMapping[4-i][j];
      }
    }
  }
  
  void display() {
    if (isVisible) {
      for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
          fill(fillMapping[i][j]);
          rect(absXPos+(i+1)*blockWidth, absYPos+(j+1)*blockWidth, blockWidth, blockWidth);  //+1 adds border
        }
      }
    }
  }
}
