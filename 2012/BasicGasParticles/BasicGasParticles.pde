final int nParticles = 200;    //Brownian-ish motion with >1000 particles
final int speedLimit = 6;

Particle[] particle;

void setup() {
  size(500, 500);
  noStroke();
  smooth();
  frameRate(60);
  
  particle = new Particle[nParticles];
  initParticles();
}

void draw() {
  fill(0, 200, 240, 150);
  rect(0, 0, width, height);
  if(mousePressed) {
    initParticles();
    background(0, 200, 240);
  }
  
  for (int i = 0; i < nParticles; i++) {
    particle[i].move();;
  }
}

void initParticles() {
  for (int i = 0; i < nParticles; i++) {
    particle[i] = new Particle(random(width), random(height), random(2*speedLimit)-speedLimit, random(2*speedLimit)-speedLimit);
  }
}
