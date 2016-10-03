import oscP5.*;  //import oscP5 library
import netP5.*;

OscP5 oscP5;  //DEFINE an OscP5 object (called oscP5)
NetAddress myRemoteLocation; //the NetAddress contains the IP and port number

float userX, userY, offset;
int beatX;
int frame;

int[][] grid; 

void setup()
{
  //(0, 150, 250)   - Light Blue
  //(250, 150, 0)   - Amber
  //(150, 150, 150) - Grey
  size(400, 400);
  background(102);
  noStroke();
  smooth();
  //frameRate(60 / 16);
  frameRate(60);
  oscP5 = new OscP5(this, 12000);  //CREATE the instance of the OscP5 object (oscP5) - listening on port 12000
  myRemoteLocation = new NetAddress("127.0.0.1", 12001); //CREATE the NetAddress object - SENDING on port 12001 (recursive IP: 127.0.0.1 = localhost)
  offset = 25 / 2; //25 is distance between centre of circles. offset by half so not touching edges
  //userX = height - offset;
  //userY = offset;
  beatX = 0; //stores current beat (16 'lights', 16 beats: 0 - 15)
  grid = new int[16][16];
  frame = 0;
}

void draw()
{
  background(102);
  
  //draw outlines:
  for (int x = 0; x < 16; x++)
  {
    for (int y = 0; y < 16; y++)
    {
      noFill();
      stroke(150);
      ellipse((x * 25) + offset, (y * 25) + offset, 20, 20);
    }
   }

  //user marker:
  noStroke();
  fill(150);
  ellipse((userX * 25) + offset, height - ((userY * 25) + offset + 1), 11, 11);
  println(userX + userY);

  //populate grid
  for (int x = 0; x < 16; x++)
  {
    for (int y = 0; y < 16; y++)
    {
      if (grid[x][y] == 1)
      {
        if (x == beatX) //beat is on cell
        {
          stroke(0, 150, 250);
          fill(0, 150, 250);

          OscMessage myOscMessage = new OscMessage("/y" + y);
          int midiPitch = y + 60;
          myOscMessage.add(midiPitch); //add y value of note

          if (frame == 0) oscP5.send(myOscMessage, myRemoteLocation); //send message
        }
        else
        {
          stroke(150);
          fill(150);
        }
        ellipse((x * 25) + offset, height - ((y * 25) + offset), 21, 21);
      }
    }
  }
  

  //beat markers:
  stroke(250, 150, 0);
  fill(250, 150, 0);
  ellipse((beatX * 25) + offset, offset, 21, 21);  //top row
  ellipse((beatX * 25) + offset, (5 * 25) + offset, 20, 20);
  ellipse((beatX * 25) + offset, (10 * 25) + offset, 20, 20);
  ellipse((beatX * 25) + offset, (15 * 25) + offset, 20, 20);




  //UPDATE BEAT EVERY 8 FRAMES
  if (frame >= 7)
  {
    frame = 0;
    if (beatX * 25 >= width - 25) beatX = 0;
    else beatX++;
  }
  
  else
  {
    frame++;
  }
  
}


void keyPressed()  //change according to input
{
  
  if (key == CODED)
  {
    if (keyCode == UP)
    {
      if (userY < 15) userY++;
    }
    else if (keyCode == DOWN)
    {
      if (userY > 0) userY--;
    }
    else if (keyCode == LEFT)
    {
      if (userX > 0) userX--;
    }
    else if (keyCode == RIGHT)
    {
      if (userX < 15) userX++;
    }
  }
   
  if (key == ' ')
  {
     if (grid[(int) userX][(int) userY] == 0) grid[(int) userX][(int) userY] = 1;
     else grid[(int) userX][(int) userY] = 0;
  }

  if (key == ENTER || key == RETURN || key == 'c') //if return/enter or 'c' is pressed, clear the array 
  {
    for (int x = 0; x < 16; x ++)
    {
      for (int y = 0; y < 16; y ++)
      {
        grid[x][y] = 0;
      }
    } 
  }
  if (key == 'a') //if 'a' is pressed, fill the array 
  {
    for (int x = 0; x < 16; x ++)
    {
      for (int y = 0; y < 16; y ++)
      {
        grid[x][y] = 1;
      }
    } 
  }
}

void mousePressed()
{
  /*
  OscMessage myOscMessage = new OscMessage("/location"); //CREATE an instance of OscMessage, with address pattern of /location -- Pd uses OSCroute separate by their patterns. patterns always begin with a /, otherwise they ignored by OSCroute
   myOscMessage.add((int) mouseX);  //add values to message
   myOscMessage.add((int) mouseY);
   
   oscP5.send(myOscMessage, myRemoteLocation); //VERY IMPORTANT - send message using oscP5.send(OscMessage, NetAddress) 
   */
  for (int x = 0; x < 16; x++)
  {
    for (int y = 0; y < 16; y++)
    {
      float xValue = (x * 25) + offset;
      float yValue = height - ((y * 25) + offset);
      if ( dist(mouseX, mouseY, xValue, yValue) < 11 )
      {
        userX = x;
        userY = y;
        if (grid[x][y] == 0) grid[x][y] = 1;
        else grid[x][y] = 0;
      }
    }
  }
}


void oscEvent(OscMessage recievedMessage) //CALLED WHEN AN OSC MESSAGE IS RECIEVED
{
  println("Recieved a message: ");
  recievedMessage.print();
}

