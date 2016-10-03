PFont font;
final int frames = 40;

int oldX, oldY, newX, newY;
float step, displacement, macroSpeed;
long time, refTime, distance, speed;

void setup() {
  size(800, 600);
  background(2, 121, 144);
  frameRate(frames);
  smooth();
  noStroke();
  
  //font = loadFont("Monaco-12.vlw");
  font = createFont("Monaco", 12);
  textFont(font);
  textAlign(LEFT);
  
  oldX = width / 2;
  oldY = height / 2;
  step = round(random(12)) + 4.0;
  
  distance = 0;
  refTime = millis();
}

void draw() {
  fill(0, 100, 140, 10);
  rect(0, 0, width, height);
  
  float angle = random(360);
  angle = radians(angle);
  
  newX = round( oldX + sin(angle)*step );
  newY = round( oldY + cos(angle)*step );
  
  stroke(255);
  line(oldX, oldY, newX, newY);
  noStroke();
  
  oldX = newX;
  oldY = newY;
  
  time = millis() - refTime;
  distance = round( (time/1000.0) * frames * step );
  speed = round(step * frames);
  displacement = round( sqrt( pow(oldX-width/2, 2) + pow(oldY-height/2, 2) ) );
  macroSpeed = round( displacement / (time/10000.0) )/10.0;
  
  fill(255);
  rect(0, height-40, width, height);
  fill(2, 121, 144);
  text("Time: " + round(time/100.0)/10.0 + " s", 15, height-15);
  text("Distance: " + round(distance/100.0)*100 + " px", 130, height-15);
  text("Displacement: " + round(displacement/10.0)*10 + " px", 285, height-15);
  text("True speed: " + speed + " px/s", 455, height-15);
  text("Mean speed: " + macroSpeed + " px/s", 630, height-15);
}

void mousePressed() {
  background(2, 121, 144);
  oldX = width / 2;
  oldY = height / 2;
  step = round(random(12)) + 4.0;
  
  distance = 0;
  refTime = millis();
}
