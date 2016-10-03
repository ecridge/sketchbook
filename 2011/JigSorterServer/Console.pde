class Console {
  PFont font;
  String[] scrollback;
  color[] colors;
  
  Console(PFont font_) {
    font = font_;
    scrollback = new String[24];
    colors = new color[24];
    
    for (int i = 0; i < 24; i++) {
      scrollback[i] = "\0";
      colors[i] = color(0, 0, 0);
    }
  }
  
  void display() {
    stroke(0);
    fill(200);
    rect(0, 0, 620, 440);    //requires 580*440 pixels
    
    textFont(font);
    textAlign(LEFT);
    
    for (int i = 0; i < 24; i++) {
      fill(colors[23-i]);
      text(scrollback[23-i], 10, 18*(i+1));
    }
  }
  
  void pushNewLine(String text) {
    for (int i = 22; i >= 0; i--) {
      scrollback[i+1] = scrollback[i];
      colors[i+1] = colors[i];
    }
    
    scrollback[0] = text;
    
    if (count >= 1) {
      colors[0] = reader.getCalibrated();
    }
    else {
      colors[0] = color(0, 0, 0);
    }
  }
  
  void appendCurrentLine(String appendage) {
    int padding = 86 - (scrollback[0].length() + appendage.length());
    for (int i = 0; i < padding; i++) {
      scrollback[0] += " ";
    }
    scrollback[0] += appendage;
  }
}
