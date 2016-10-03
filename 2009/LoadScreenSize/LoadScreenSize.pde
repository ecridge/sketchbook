String[] settings;    //DEFINE A STRING ARRAY
String[] newResolution;  //DEFINE AN ARRAY TO STORE NEW VALUES (IF THERE ARE ANY)
int sizeX, sizeY;
PImage i800, i1024, i1280, i1680;
int y800, y1024, y1280, y1680;
int x, y; //values to store mouse click locations
boolean b800, b1024, b1280, b1680;
boolean flash;

int i;

void setup()
{
  settings = loadStrings("settings.txt");
  newResolution = new String[2];
  sizeX = int(settings[0]); //width (x) of the screen is the number in the first line of the file
  sizeY = int(settings[1]); //NOTE: int(string[x]) converts a string to an int

  i800 = loadImage("800x600.png");
  i1024 = loadImage("1024x768.png");
  i1280 = loadImage("1280x800.png");
  i1680 = loadImage("1680x1050.png");

  println("Loaded width: " + sizeX + "   Loaded height: " + sizeY);

  size(sizeX, sizeY);
  background(0, 0, 255);
  noStroke();
  smooth();
  frameRate(30);
  
  y800 = height - 140;   //y location of 800x600 button
  y1024 = height - 110;  //y location of 1024x768 button
  y1280 = height - 80;   //y location of 1280x800 button
  y1680 = height - 50;   //y location of 1680x1050 button
  
  x = 0;  //initialize mouse click storers
  y = 0;
  
  b800 = false;
  b1024 = false;
  b1280 = false;
  b1680 = false;
  
  flash = false;
  
  if (sizeX == 800) b800 = true;        //depending on screen size, set one to true (to show in resolution list)
  else if (sizeX == 1024) b1024 = true;
  else if (sizeX == 1280) b1280 = true;
  else if (sizeX == 1680) b1680 = true;
  else b800 = true;
}


void draw()
{
  background(0, 0, 255);
  noCursor();
  
  resolution();  //call function (below) to deal with the buttons and saving
  
  fill(255);
  image(i800, 25, y800);
  image(i1024, 25, y1024);
  image(i1280, 25, y1280);
  image(i1680, 25, y1680);
  
  if (flash) flash();
  
  println(b800 + " " + b1024 + " " + b1280 + " " + b1680);
  println(flash + "  " + i);
}

void mousePressed() //stores where the mouse was last pressed
{
  x = mouseX;
  y = mouseY;
  
  flash = true;
}

void resolution()
{
  fill(46, 191, 254);
  rect(mouseX - 2, mouseY - 2, 4, 4);
  
  if (mouseX > 25 && mouseX < 25 + 100 && mouseY > y800 && mouseY < y800 + 25 || b800)
  {
    rect(25 - 5, y800, 5, 25);
    rect(25 + 100, y800, 5, 25);
  }
  
  if (mouseX > 25 && mouseX < 25 + 100 && mouseY > y1024 && mouseY < y1024 + 25 || b1024)
  {
    rect(25 - 5, y1024, 5, 25);
    rect(25 + 100, y1024, 5, 25);
  }
  
  if (mouseX > 25 && mouseX < 25 + 100 && mouseY > y1280 && mouseY < y1280 + 25 || b1280)
  {
    rect(25 - 5, y1280, 5, 25);
    rect(25 + 100, y1280, 5, 25);
  }
  
  if (mouseX > 25 && mouseX < 25 + 100 && mouseY > y1680 && mouseY < y1680 + 25 || b1680)
  {
    rect(25 - 5, y1680, 5, 25);
    rect(25 + 100, y1680, 5, 25);
  }
  
  
  
  if (x > 25 && x < 25 + 100 && y > y800 && y < y800 + 25)
  {
    b800 = true;
    b1024 = false;
    b1280 = false;
    b1680 = false;
    
    int newWidth = 800;
    int newHeight = 600;
    newResolution[0] = Integer.toString(newWidth);
    newResolution[1] = Integer.toString(newHeight);
    saveStrings("settings.txt", newResolution);
  }
  
  else if (x > 25 && x < 25 + 100 && y > y1024 && y < y1024 + 25)
  {
    b800 = false;
    b1024 = true;
    b1280 = false;
    b1680 = false;
    
    int newWidth = 1024;
    int newHeight = 768;
    newResolution[0] = Integer.toString(newWidth);
    newResolution[1] = Integer.toString(newHeight);
    saveStrings("settings.txt", newResolution);
  }
  
  else if (x > 25 && x < 25 + 100 && y > y1280 && y < y1280 + 25)
  {
    b800 = false;
    b1024 = false;
    b1280 = true;
    b1680 = false;
    
    int newWidth = 1280;
    int newHeight = 800;
    newResolution[0] = Integer.toString(newWidth);
    newResolution[1] = Integer.toString(newHeight);
    saveStrings("settings.txt", newResolution);
  }
  
  else if (x > 25 && x < 25 + 100 && y > y1680 && y < y1680 + 25)
  {
    b800 = false;
    b1024 = false;
    b1280 = false;
    b1680 = true;
    
    int newWidth = 1680;
    int newHeight = 1050;
    newResolution[0] = Integer.toString(newWidth);
    newResolution[1] = Integer.toString(newHeight);
    saveStrings("settings.txt", newResolution);
  }
  
}

void flash()
{
 if (i <= 0) i = 255;
 i -= 16;
 fill(255, 255, 0, i);
 rect(0, 0, width, height);
 if (i <= 0) flash = false; 
}


