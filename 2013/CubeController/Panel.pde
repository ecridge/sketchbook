class Panel {
  int xPos, yPos, id;
  PImage icon;
  PFont font;
  String text;
  
  Panel(int id_, int xPos_, int yPos_, PImage icon_, String text_) {
    id = id_;
    xPos = xPos_;
    yPos = yPos_;
    icon = icon_;
    text = text_;
    
    font = loadFont("font.vlw");
  }
  
  void display() {
    noStroke();
    if (selected == id) {
      fill(255, 200, 0);
    }
    else if (mouseX > xPos && mouseX < xPos+135 && mouseY > yPos-10 && mouseY < yPos+180) {
      fill(200);
    }
    else {
      fill(150);
    }
    rect(xPos, yPos, 135, 180);
    image(icon, xPos+23, yPos+23);
    
    textFont(font);
    textAlign(CENTER);
    fill(50);
    text(text, xPos+68, yPos+140);
  }
  
  boolean check() {
    if (mouseX > xPos && mouseX < xPos+135 && mouseY > yPos-10 && mouseY < yPos+180) {
      return true;
    }
    else {
      return false;
    }
  }
  
  int getId() {
    return id;
  }
}
