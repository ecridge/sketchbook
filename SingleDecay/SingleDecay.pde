PFont titleFont, infoFont;
color bgColor = color(0, 200, 240);

Nucleus[][] sample;

void setup() {
  size(1280, 800);
  frameRate(60);
  smooth();
  background(bgColor);
  
  titleFont = loadFont("title_font.vlw");
  infoFont = loadFont("info_font.vlw");
  sample = new Nucleus[40][40];
  
  for (int i = 0; i < 40; i ++) {
    for (int j = 0; j < 40; j++) {
      sample[i][j] = new Nucleus(i, j);
    }
  }
}

void draw() {
  background(bgColor);
  stroke(255);
  noFill();
  rect(0, 0, width-1, height-1);
  
  fill(255);
  noStroke();
  textFont(titleFont);
  textAlign(CENTER);
  text("NUCLEAR DECAY MODEL", width/2, 60);
  
  pushMatrix();    //draw sample
    translate(50, 150);
    stroke(255);
    fill(100);
    rect(-10, -10, 605, 605);
  
    fill(255);
    noStroke();
    textFont(infoFont);
    textAlign(LEFT);
    text("Sample:", -10, -25);
  
    for (int i = 0; i < 40; i ++) {
      for (int j = 0; j < 40; j++) {
        sample[i][j].update();
        sample[i][j].display();
      }
    }
  popMatrix();
  
  pushMatrix();    //draw gui
    translate(700, 140);
    stroke(255);
    fill(100);
    rect(0, 0, 530, 340);
  
    fill(255);
    noStroke();
    textFont(infoFont);
    textAlign(LEFT);
    text("Interface:", 0, -15);
  popMatrix();
  
  pushMatrix();    //draw graph 1
    translate(700, 560);
    stroke(255);
    fill(100);
    rect(0, 0, 250, 185);
  
    fill(255);
    noStroke();
    textFont(infoFont);
    textAlign(LEFT);
    text("Number graph:", 0, -15);
  popMatrix();
  
  pushMatrix();    //draw graph 2
    translate(980, 560);
    stroke(255);
    fill(100);
    rect(0, 0, 250, 185);
  
    fill(255);
    noStroke();
    textFont(infoFont);
    textAlign(LEFT);
    text("Activity graph:", 0, -15);
  popMatrix();
}
