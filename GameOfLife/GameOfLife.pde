/*  Implementation of Conway's game of life
 *  using arrays of Cell objects
 *
 *  Click to resrart with randomly populated grid of cells.
 *  Use the UP and DOWN keys to adjust simulation speed.
 *
 *  cridge 17.8.12
 */

PFont infoFont;
String infoText, titleText;

int gridWidth, gridHeight;
int generation = 0;
int speed = 5;                                   //use 30fps (preset 5) at start
int[] speedPreset = {1, 2, 4, 8, 15, 30, 60};    //preset speeds

Cell[][] grid;
int[][] gridNeighbours;

void setup() {  
  size(1280, 800);
  frameRate(speedPreset[speed]);
  background(100, 0, 120);
  noStroke();
  smooth();
  
  infoFont = loadFont("LucidaGrande-Bold-16.vlw");
  infoText = "Generation 0 @ 30Hz";
  titleText = "Conway's Game of Life  |  Click to restart, space to clear. Arrow keys adjust speed.";
  textFont(infoFont);
  
  gridWidth = width/8;
  gridHeight = height/8;

  gridNeighbours = new int[gridWidth][gridHeight];

  grid = new Cell[gridWidth][gridHeight];  //creates each cell within grid
  for (int i = 0; i < gridWidth; i++) {
    for (int j = 0; j < gridHeight; j++) {
      grid[i][j] = new Cell(i, j, false);
    }
  }
}

void draw() {
  background(100, 0, 120);

  for (int i = 0; i < gridWidth; i++) {    // record number of live neighbours for each cell
    for (int j = 0; j < gridHeight; j++) {
      gridNeighbours[i][j] = grid[i][j].countNeighbours();
    }
  }

  for (int i = 0; i < gridWidth; i++) {    // updates and displays each cell
    for (int j = 0; j < gridHeight; j++) {
      grid[i][j].update(gridNeighbours[i][j]);
      grid[i][j].display();
    }
  }
  
  generation++;
  infoText = "Generation " + generation + " @ " + speedPreset[speed] + "Hz";
  fill(255);
  textAlign(LEFT);
  text(titleText, 10, height-10);
  textAlign(RIGHT);
  text(infoText, width-10, height-10);
}

void mousePressed() {  //called once upon mouse down
  restart();
}

void keyPressed() {    //called once on any key down
  if (keyCode == UP || keyCode == RIGHT) {
    if (speed < 6) speed++;
    else speed = 6;
  }
  if (keyCode == DOWN || keyCode == LEFT) {
    if (speed > 0) speed--;
    else speed = 0;
  }
  
  frameRate(speedPreset[speed]);
  
  if (key == 'r') restart();
  if (key == ' ') clear();
}

void clear() {
  for (int i = 0; i < gridWidth; i++) {
    for (int j = 0; j < gridHeight; j++) {
      grid[i][j].isAlive = false;
    }
  }
  generation = 0;
}

void restart() {
  clear();
  int sparseness = (int) random(25);
  for (int i = 0; i < gridWidth; i++) {
    for (int j = 0; j < gridHeight; j++) {
      int r  = (int) random(sparseness);
      if (r == 0) grid[i][j].isAlive = true;    //randomly populates grid with random density
      else grid[i][j].isAlive = false;
    }
  }
}

