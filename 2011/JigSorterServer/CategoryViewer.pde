class CategoryViewer {
  int selected;
  color[] categoryColour = { color(255, 0, 0), color(255, 255, 0), color(0, 255, 0), color(0, 0, 255), color(255), color(0) };
  
  CategoryViewer() {
    selected = RED;
  }
  
  void setSelected(int newSelection) {
    selected = newSelection;
  }
  
  int chooseCategory(float hue, float brightness) {
    int colour;
    if (hue > 40.0 && hue <= 65.0) { 
      colour = YELLOW;
    }
    else if (hue > 65.0 && hue <= 175.0) {
      colour = GREEN;
    }
    else if (hue > 175.0 && hue <= 290.0) {
      colour = BLUE;
    }
    else {
      colour = RED;
    }
    
    if (brightness <= unsortedThreshold) {
      return UNSORTED;
    }
    else if (brightness >= whiteThreshold) {
      return WHITE;
    }
    else {
      return colour;
    }
  }
  
  void display() {
    stroke(0);
    fill(200);
    rect(0, 0, 580, 420);    //requires 580*420 pixels
    
    pushMatrix();
      translate(290, 210);
      stroke(0);
      fill(255);
      ellipse(0, 0, 380, 380);
      
      for (int i = 0; i < 6; i++) {
        fill(categoryColour[i]);
        ellipse(127, 0, 117, 117);
        
        if (selected == i) {
          noStroke();
          fill(200, 200);
          ellipse(127, 0, 48, 48);
          stroke(0);
        }
        
        rotate(radians(-60));
      }
    popMatrix();
  }
}
