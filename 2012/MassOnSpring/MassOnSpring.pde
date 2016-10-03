/* 
 * Simulates a spring in one dimension fixed at the top
 * but freely suspended at the bottom, and of negligible
 * mass. A large load is added to the bottom and can be
 * dragged vertically to give amplitude.
 *
 * The mass of the load and the spring constant can be
 * changed.
 * 
 * Cridge 18.11.12
 */

final int PPM = 4350;
final int FPS = 60;
final float g = 9.81;

Spring spring;
Load load;

void setup() {
  frameRate(FPS);
  size(600, 600);
  background(0, 200, 240);
  smooth();
  
  spring = new Spring(width/2, height/7, 0.020, 30.1);
  load = new Load(spring.freePoint.x, spring.freePoint.y, 4);
}

void draw() {
  background(0, 200, 240);
  strokeWeight(2);
  line(0, height/7, width, height/7);
  
  spring.update(load.weight);
  spring.display();
  
  load.update(spring.freePoint.y);
  load.display();
}

void mousePressed() {
  load.setNMasses( int(random(18)) );
}

void keyPressed() {
  int n = load.getNMasses();
  if (keyCode == UP) {
    n++;
  }
  else if (keyCode == DOWN) {
    n--;
  }
  n = constrain(n, 0, 18);
  load.setNMasses(n);
}
