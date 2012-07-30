import java.util.Random;

Random r;
Paintbrush brush;

void setup() {
  size(640, 360);
  background(255);
  colorMode(HSB, 360);
  
  r = new Random();
  brush = new Paintbrush(r);
}

void draw() {
}

void mousePressed() {
  brush.splatter(mouseX, mouseY);
}

void keyPressed() {
  background(360);
}
