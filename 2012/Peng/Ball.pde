class Ball {
  PVector position, velocity;
  int ballRadius = 10;
  
  Ball(int startX, int startY) {
    position = new PVector(startX, startY);
    velocity = new PVector(0.0, 0.0);
  }
  
  int update() {
    int returnCode;
    if (position.x <= ballRadius) {
      returnCode = COMPUTER;
      if (soundsOn) missSound.play(0);
      reset();
    }
    else if (position.x >= width-ballRadius) {
      returnCode = PLAYER;
      if (soundsOn) scoreSound.play(0);
      reset();
    }
    else {
      if (position.y <= ballRadius || position.y >= height-ballRadius) {
        velocity.y *= -1.0;
        velocity.x *= 1.2;
        if (soundsOn) playPingSound();
      }
      else if (position.x >= player.xCoord && position.x <= player.xCoord+player.paddleWidth
            && position.y >= player.yCoord && position.y <= player.yCoord+player.paddleHeight) {
        velocity.x *= -1.2;
        velocity.y += player.velocity.y;
        if (soundsOn) playPingSound();
      }
      else if (position.x >= computer.xCoord && position.x <= computer.xCoord+computer.paddleWidth
            && position.y >= computer.yCoord && position.y <= computer.yCoord+computer.paddleHeight) {
        velocity.x *= -1.2;
        velocity.y += computer.velocity.y;
        if (soundsOn) playPingSound();
      }
      returnCode = NOBODY;
    }
    
    position.x += velocity.x;
    position.y += velocity.y;
    
    display();
    return returnCode;
  }
  
  void display() {
    fill(200, 250, 0);
    ellipse(position.x, position.y, ballRadius*2, ballRadius*2);
  }
  
  void reset() {
    ball.position.x = width/2;
    ball.position.y = height/2;
    ball.velocity.x = ( (int) random(2) )*2-1;  //(int)random(2) will return either 0 or 1, so doubled then minus 1 will return -1.0 or 1.0
    ball.velocity.y = ( (int) random(2) )*2-1;
  }
  
  void playPingSound() {
    int pingNumber = (int) random(5);
    switch (pingNumber) {
      case 0:
        ping1.play(0);
      break;
      case 1:
        ping2.play(0);
      break;
      case 2:
        ping3.play(0);
      break;
      case 3:
        ping4.play(0);
      break;
      case 4:
        ping5.play(0);
      break;
    }
  }
    
}
