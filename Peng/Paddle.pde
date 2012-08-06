class Paddle {
  PVector position, velocity, acceleration;
  int paddleWidth = 20;
  int paddleHeight = 80;
  float xCoord, yCoord;
  
  Paddle(int screenPosition) {
    position = new PVector(screenPosition, height/2);
    velocity = new PVector(0.0, 0.0);
    acceleration = new PVector(0.0, 0.0);
  }
  
  void update() {
    velocity.y += acceleration.y;
    position.y += velocity.y;
    
    if (position.y <= paddleHeight/2) {
      position.y = paddleHeight/2;
      velocity.y = 0.0;
    }
    else if (position.y >= height-paddleHeight/2) {
      position.y = height-paddleHeight/2;
      velocity.y = 0.0;
    }
    
    xCoord = position.x-paddleWidth/2;
    yCoord = position.y-paddleHeight/2;
     
    display();
  }
  
  void display() {
    fill(200, 240, 0);
    rect(xCoord, yCoord, paddleWidth, paddleHeight);
  }
}
