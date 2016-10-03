/*
 *  Pattern generation program based on Fractal.Invaders by Jared Tarbell
 *  
 *  5x5 'invader' glyphs fill screen and are generated randomly.
 *  Glyphs have lateral symmetry and random colour.
 *
 *  cridge 18.8.12
 */

int gridSize = 40;
int glyphWidth = 12;
int blockWidth = 2;
int countX, countY;

Glyph[][] grid;
/*color[] scheme = { color(36, 210, 243),
                   color(294, 144, 44),
                   color(220, 47, 181),
                   color(66, 215, 38) };*/
 
color[] scheme = { color(189, 195, 198),
                   color(/*123, 195, 66*/66, 215, 38),
                   color(74, 178, 214),
                   color(0, 101, 148) }; 
 
void setup() {
  size(482, 482);
  frameRate(60);
  background(255);
  smooth();
  noStroke();
  
  countX = 0;
  countY = 0;
  
  //create glyph array
  grid = new Glyph[gridSize][gridSize];
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      //grid[i][j] = new Glyph(i, j, color(random(255), random(255), random(255), random(255)) );
      grid[i][j] = new Glyph(i, j, scheme[int(random(4))] );
    }
  }
}

void draw() {
  //reveal glyphs one by one
  if (countX < gridSize) {
    if (countY < gridSize) {
      grid[countX][countY].isVisible = true;
      countY++;
    }
    else {
      countY = 0;
      countX++;
    }
  }
  else countX = 0;
    
  
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      grid[i][j].display();
    }
  }
}

void mousePressed() {
  background(random(255), random(255), random(255), random(255));
  countX = (int) (mouseX*gridSize)/width;
  countY = (int) (mouseY*gridSize)/height;
  
  //regenerate glyphs
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      grid[i][j] = new Glyph(i, j, color(random(255), random(255), random(255), random(255)) );
    }
  }
}
   
