class Overview {
  PFont font;
  float nTotal, topCatCount;
  color[] categoryColour = { color(255, 0, 0), color(255, 255, 0), color(0, 255, 0), color(0, 0, 255), color(255), color(0) };
  float[] categoryCount;
  
  Overview(PFont font_) {
    font = font_;
    nTotal = 0.0;
    topCatCount = 1.0;
    
    categoryCount = new float[6];
  }
  
  void display() {
    
    stroke(0);
    fill(200);
    rect(0, 0, 620, 220);    //requires 580*220 pixels
    
    for (int i = 0; i < 6; i++) {
      float barLength = categoryCount[i] / topCatCount;
      barLength *= 535.0;
      
      fill(categoryColour[i]);
      rect(20, 20+(30*i), barLength, 30);
    }
    
    textFont(font);
    textAlign(RIGHT);
    noStroke();
    fill(0);
    
    text(int(categoryCount[0]), 600, 43);
    text(int(categoryCount[1]), 600, 73);
    text(int(categoryCount[2]), 600, 103);
    text(int(categoryCount[3]), 600, 133);
    text(int(categoryCount[4]), 600, 163);
    text(int(categoryCount[5]), 600, 193);
  }
  
  void incrementNTotal() {
    nTotal += 1.0;
  }
  
  void incrementCatCount(int category) {
    categoryCount[category] += 1.0;
    
    if (categoryCount[category] > topCatCount) {
      topCatCount = categoryCount[category];
    }
  }
}
