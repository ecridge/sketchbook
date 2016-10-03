import ddf.minim.*;

Minim minim;
AudioSnippet ping1, ping2, ping3, ping4, ping5, winSound, loseSound, scoreSound, missSound, restartSound;

/*  Quick pong clone
 *
 *  W and S or UP and DOWN to move player paddle,
 *  SPACE to restart game. Scores printed to prompt.
 *
 *  Hitting the ball with a moving paddle adds vertical spin; 
 *  horizontal speed increases with number of rebounds.
 *
 *  Computer paddle roughly follows ball but with speed cap.
 *  Speed cap increases as player score gets higher.
 *
 *  cridge 7.8.12
 */

Ball ball;
Paddle player, computer;

PFont scoresFont;
String scoresText;

int playerScore, computerScore;
float difficulty = 1.0;

final int PLAYER = 0;
final int COMPUTER = 1;
final int NOBODY = 2;

boolean soundsOn = true;

void setup() {
  size(800, 600);
  background(255);
  noStroke();
  smooth();
  frameRate(60);
  
  minim = new Minim(this);
  ping1 = minim.loadSnippet("p1.wav");
  ping2 = minim.loadSnippet("p2.wav");
  ping3 = minim.loadSnippet("p3.wav");
  ping4 = minim.loadSnippet("p4.wav");
  ping5 = minim.loadSnippet("p5.wav");
  winSound = minim.loadSnippet("ws.wav");
  loseSound = minim.loadSnippet("ls.wav");
  scoreSound = minim.loadSnippet("ss.wav");
  missSound = minim.loadSnippet("ms.wav");
  restartSound = minim.loadSnippet("rs.wav");
  
  playerScore = 0;
  computerScore = 10;
  
  scoresFont = loadFont("LucidaGrande-Bold-16.vlw");
  scoresText = "PENG [PRESS SPACE]";
  
  ball = new Ball(width/2, height/2);
  player = new Paddle(40);
  computer = new Paddle(width-40);
}

void draw() {
  background(255);
  fill(0, 200, 250);
  rect(4, 4, width-8, height-8);
  fill(255);
  rect(0, height/2-2, width, 4);
  fill(215);
  rect(width/2-2, 0, 4, height);
  
  if (mousePressed || keyPressed && key == ' ') {
    ball.reset();
    playerScore = 0;
    computerScore = 0;
    scoresText = "NEW GAME [FIRST TO 11]";
    println("==== NEW GAME =====\n");
    
    if (soundsOn) {
      restartSound.play(0);
      winSound.rewind();  //only played once per game so call them where they left off and only rewind at game start
      loseSound.rewind();
    }
  }
  
  if (keyPressed) {
    if (key == 'w' || key == 'W' || keyCode == UP) player.acceleration.y = -0.5;
    if (key == 's' || key == 'W' || keyCode == DOWN) player.acceleration.y = 0.5;
  }
  else {
    player.acceleration.y = 0.0;
    player.velocity.y = 0.0;
  }
  
  if (ball.position.y <= computer.position.y - computer.paddleHeight/3) computer.velocity.y = -(difficulty + playerScore/10);
  else if (ball.position.y >= computer.position.y + computer.paddleHeight/3) computer.velocity.y = difficulty + playerScore/10;
  else {
    computer.velocity.y = 0.0;
  }
  
  int winner = ball.update();
  player.update();
  computer.update();
  
  if (winner != NOBODY) {
    if (winner == PLAYER) playerScore++;
    else computerScore++;
    if (playerScore >= 11) {
      scoresText = "YOU WIN [PRESS SPACE]";
      if (soundsOn) winSound.play();
    }
    else if (computerScore >= 11) {
      scoresText = "YOU LOSE [PRESS SPACE]";
      if (soundsOn) loseSound.play();
    }
    else scoresText = playerScore + "-" + computerScore;
    println("Player "+playerScore+"-"+computerScore+" Computer");
  }
  
  textFont(scoresFont);
  fill(255);
  textAlign(RIGHT);
  text(scoresText, width-10, height-10);
}

void stop() {
  ping1.close();
  ping2.close();
  ping3.close();
  ping4.close();
  ping5.close();
  winSound.close();
  loseSound.close();
  scoreSound.close();
  missSound.close();
  restartSound.close();
  
  minim.stop();
  super.stop();
}
