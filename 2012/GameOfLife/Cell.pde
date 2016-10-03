/*
 *  Each point on the grid is a cell object
 */

class Cell {
  int gridX, gridY;
  int xPosition, yPosition, xCellSpacing, yCellSpacing;
  boolean isAlive = false;
  
  Cell(int gridX_, int gridY_, boolean isAlive_) {
    gridX = gridX_;
    gridY = gridY_;
    xCellSpacing = width / gridWidth;
    yCellSpacing = height / gridHeight;
    xPosition = (gridX * xCellSpacing) + (xCellSpacing / 2);
    yPosition = (gridY * yCellSpacing) + (yCellSpacing / 2);
    isAlive = isAlive_;
  }
  
  int countNeighbours() {
    int _nNeighbours = 0;
    
    if (gridX > 0 && gridY > 0) {    //check neighbouring cells clockwise from top left *where they exist*
      if (grid[gridX-1][gridY-1].isAlive) _nNeighbours++;
    }
    if (gridY > 0) {
      if (grid[gridX][gridY-1].isAlive) _nNeighbours++;
    }
    if (gridX < gridWidth-1 && gridY > 0) {
      if (grid[gridX+1][gridY-1].isAlive) _nNeighbours++;
    }
    if (gridX < gridWidth-1) {
      if (grid[gridX+1][gridY].isAlive) _nNeighbours++;
    }
    if (gridX < gridWidth-1 && gridY < gridHeight-1) {
      if (grid[gridX+1][gridY+1].isAlive) _nNeighbours++;
    }
    if (gridY < gridHeight-1) {
      if (grid[gridX][gridY+1].isAlive) _nNeighbours++;
    }
    if (gridX > 0 && gridY < gridHeight-1) {
      if (grid[gridX-1][gridY+1].isAlive) _nNeighbours++;
    }
    if (gridX > 0) {
      if (grid[gridX-1][gridY].isAlive) _nNeighbours++;
    }
    
    return _nNeighbours;
  }
  
  void update(int nNeighbours_) {
    if (isAlive) {
      if (nNeighbours_ < 2 || nNeighbours_ > 3) isAlive = false;    //kill a live cell if too many or too little neighbours
    }
    else if (!isAlive && nNeighbours_ == 3) isAlive = true;    //make a new live cell if right number of neighbours
  }
  
  void display() {
    fill(200, 200, 0);
    if (isAlive) {
      ellipse(xPosition, yPosition, width/(gridWidth*2), height/(gridHeight*2));
    }
  }  
}
