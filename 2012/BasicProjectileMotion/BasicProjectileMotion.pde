Particle p;

void setup() {
  size(400, 400);
  background(0, 200, 250);
  smooth();
  noStroke();

  p = new Particle(3);
}

void draw() {
  fill(0, 200, 250, 5);
  rect(0, 0, width, height);

  if (mousePressed) {
    p.restart();
  }

  p.update();
  p.checkEdges();
  p.display();
}

class Particle {
  float d;
  PVector pos;
  PVector vel;
  PVector acc;

  Particle(float d_) {
    d = d_;
    pos = new PVector(random(width), random(height));
    vel = new PVector(random(-5, 5), random(-5, 5));
    acc = new PVector(0, 0.25);
  }

  void update() {
    vel.add(acc);  //  velocity changes by acceleration each frame
    pos.add(vel);  //  location changes by velocity every frame
    print(vel.y);
    print("\n");
  }

  void checkEdges() {
    if (pos.x - d/2 < 0 || pos.x + d/2 > width) {
      vel.x *= -1;
    }

    if (pos.y - d/2 < 0 || pos.y + d/2 > height) {
      vel.y *= -1;
    }
  }

  void display() {
    fill(255);
    ellipse(pos.x, pos.y, d, d);
  }

  void restart() {    
    fill(0, 200, 250);
    rect(0, 0, width, height);

    pos.x = random(width);
    pos.y = random(height);
    vel.x = random(-5, 5);
    vel.y = random(-5, 5);
  }
}

