import TUIO.*;

TuioProcessing tuioClient;    //EXTREMELY IMPOTRTANT!!!!!!!!!!!!!!!!!!!!!!

void setup()
{
  size(900, 900);
  background(102);
  noStroke();
  smooth();
  radius = (width - 100) / 80;
  diameter = 2 * radius;
  tuioClient = new TuioProcessing(this);    //EXTREMELY IMPOTRTANT!!!!!!!!!!!!!!!!!!!!!!
}

int radius, diameter; 
int id_added, id_removed, id_updated, cursor_added, cursor_removed, cursor_updated;
float objX = width / 2;
float objY = height / 2;
boolean fiducial_0_only = false;

void addTuioObject(TuioObject tobj)       //called when an is placed on the table
{
  id_added = tobj.getSymbolID();
  println("Object " + id_added + " added.");
  if (id_added == 0) fiducial_0_only = true;
  else fiducial_0_only = false;
}

void removeTuioObject(TuioObject tobj)    //called when an object is removed from the table
{
  id_removed = tobj.getSymbolID();
  println("Object " + id_removed + " removed.");
  fiducial_0_only = false;
}

void updateTuioObject(TuioObject tobj)    //called when an object is moved
{
    objX = tobj.getX() * width;
    objY = tobj.getY() * height;
  id_updated = tobj.getSymbolID();
  println("Object " + id_updated + " updated:   X = " + tobj.getX() * width + ";   Y = " + tobj.getY() * height);
}

void addTuioCursor(TuioCursor tcur)      //called when a finger is placed on the table
{
  cursor_added = tcur.getCursorID();
  //println("Cursor " + cursor_added + " added.");
}

void removeTuioCursor(TuioCursor tcur)    //called when a finger is removed from the table
{
  cursor_removed = tcur.getCursorID();
  //println("Cursor " + cursor_removed + " removed.");
}

void updateTuioCursor(TuioCursor tcur)    //called when a finger is moved
{
  cursor_updated = tcur.getCursorID();
  //println("Cursor " + cursor_updated + " updated.");
}

void refresh(TuioTime bundleTime)        //called after each bundle - use to repaint screen
{
  if (fiducial_0_only) fill(0, 255, 0);
  else fill(255, 0, 0);
  redraw();
}


void draw()
{
    background(102);
  for (int x = 0; x < (width - 100); x += diameter )
  {
    for (int y = 0; y < (height - 100); y += diameter)
    {
      int circleSize = 5;
      if (fiducial_0_only)
      {
        circleSize = (int) (dist(objX - 50, objY - 50, x + radius, y + radius) - 25) / 25;
      }
      else
      {
        circleSize = 5;
      }
      ellipse(x + radius + 50, y + radius + 50, circleSize, circleSize);
    }
  }
}
