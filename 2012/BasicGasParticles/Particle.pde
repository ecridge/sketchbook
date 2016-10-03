class Particle {
  float xpos, ypos;
  float xspeed, yspeed;
  
  Particle(float x, float y, float v, float w) {
    xpos = x;
    ypos = y;
    xspeed = v + 1;
    yspeed = w + 1;
    
  }
  
  void move() {
    if(xpos > width || xpos < 0) xspeed *= -1;
    if(ypos > height || ypos < 0) yspeed *= -1;
    
    xpos += xspeed;
    ypos += yspeed;
    
    fill(255);
    ellipse(xpos, ypos, 10, 10);
  }
}
