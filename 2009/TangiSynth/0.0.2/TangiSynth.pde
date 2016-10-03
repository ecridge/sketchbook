import oscP5.*;
import netP5.*;
import TUIO.*;

OscP5 oscP5;  //DEFINE an OscP5 object (called oscP5)
NetAddress myRemoteLocation; //the NetAddress contains the IP and port number

TuioProcessing tuioClient;    //define instance of TuioProcessing


String[] settings;  //define string array

PImage splash, help_icon, piano_icon, help_image;
PImage bg, sine_image, sawtooth_image, square_image, noise_image;
PImage tonic_image;

boolean justLoaded;
boolean flash;

boolean help, sine, sawtooth, square, wNoise;

int screenSizeX, screenSizeY, splashWidth, splashHeight;
int flashAlpha;




void setup()
{
  //READ DESIRED RESOLUTION FROM FILE FIRST
  settings = loadStrings("files/settings.txt");
  screenSizeX = int(settings[0]);  //reads value from first line of file
  screenSizeY = int(settings[1]);  //int(string[#]) is a funstion to convert a string to an int
  
  //SETUP
  strokeWeight(5);  //SET STROKE THICKNESS
  size(screenSizeX, screenSizeY);
  frameRate(30);
  
  //CHOOSE BACKground IMAGE
  switch (screenSizeX)
  {
      case 800:  //if screen is 800 wide, load 800x600 background
      bg = loadImage("images/bg_800x600.png");  //bg = loadImage("images/bg_1680x1050.png");  //set background image
      break;
      
      case 1024:
      bg = loadImage("images/bg_1024x768.png");
      break;
      
      case 1280:
      bg = loadImage("images/bg_1280x800.png");
      break;
      
      case 1680:
      bg = loadImage("images/bg_1680x1050.png");
      break;
      
      default:
      bg = loadImage("images/bg_800x600.png");  //assume size is 800x600
      break;
  }
   
  //LOAD IMAGES
  splash = loadImage("images/splash.png");  //load splash screen
  help_image = loadImage("images/help.png");  //load help screen
  help_icon = loadImage("images/help_icon.png");
  piano_icon = loadImage("images/piano_icon.png");
  sine_image = loadImage("images/sine.png");  //load image for sine wave
  sawtooth_image = loadImage("images/sawtooth.png");
  square_image = loadImage("images/square.png");
  noise_image = loadImage("images/noise.png");
  tonic_image = loadImage("images/tonic.png");
  justLoaded = true;  //display splash screen
  splashWidth = 400;
  splashHeight = 300;
  
  background(bg);  //paint background
  smooth();
  noStroke();
  
  flashAlpha = 0;
  
  tuioClient = new TuioProcessing(this);    //create instance of TuioProcessing
  oscP5 = new OscP5(this, 12000);  //CREATE the instance of the OscP5 object (oscP5) - listening on port 12000
  myRemoteLocation = new NetAddress("127.0.0.1", 12001); //CREATE the NetAddress object - SENDING on port 12001 (recursive IP: 127.0.0.1 = localhost)
  
  //INIT BOOLEANS
  help = false;
  sine = false;
  sawtooth = false;
  square = false;
  wNoise = false;
  
  flash = false;  //to flash the screen when a screenshot is taken
  
}





int id_added, id_removed, id_updated, cursor_added, cursor_removed, cursor_updated;

void addTuioObject(TuioObject tobj)       //called when an is placed on the table
{
  id_added = tobj.getSymbolID();
  //println("Object " + id_added + " added.");
  if (justLoaded) justLoaded = false;   //if splash screen is up, take it down
  
  if (id_added == 0) help = true;
  else if (id_added == 20) sine = true;      //ELSE IF since only one puck can be added at a time
  else if (id_added == 21) sawtooth = true;
  else if (id_added == 22) square = true;
  else if (id_added == 23) wNoise = true;

  
/*
  float x = tobj.getX();
  float y = tobj.getY();
  float angle = PI;  //MUST START AS PI INSTEAD AS 0 BECAUSE OF MIRROR EFFECT
*/

/*
  if (id_added == 20)   
  {
    sineX = x;
    sineY = 1 - y;    //1 - y CORRECTS Y AXIS INVERSION
    sineAngle = angle;
  }
  
  else if...  //ELSE IF since only one object cane be updated at a time
*/

}

void removeTuioObject(TuioObject tobj)    //called when an object is removed from the table
{
  id_removed = tobj.getSymbolID();
  
  if (id_removed == 0)
  {
    help = false;
    help();
  }
  
  //println("Object " + id_removed + " removed.");
 
 /* 
  if (id_removed == 20)
  {
    sine = false;
    OscMessage myOscMessage = new OscMessage("/sine"); //CREATE an instance of OscMessage, with address pattern of "/sine" -- Pd uses OSCroute separate by their patterns. patterns always begin with a /, otherwise they ignored by OSCroute
    myOscMessage.add(0);      //PITCH
    myOscMessage.add(sine);  //VOLUME add value of 0 (sine is now false)
    oscP5.send(myOscMessage, myRemoteLocation); //SEND MESSAGE TO PD
    sineAngle = PI;
  }
*/
}

void updateTuioObject(TuioObject tobj)    //called when an object is moved
{
  float x = tobj.getX();
  float y = tobj.getY();
  float angle = tobj.getAngle();
  id_updated = tobj.getSymbolID();
  //println("Object " + id_updated + " updated:   X = " + x + ";   Y = " + y);

/*  
  if (id_updated == 20)
  {
    sineX = x;
    sineY = 1 - y;    //1 - y CORRECTS Y AXIS INVERSION
    sineAngle = angle;
  }
*/
}

void addTuioCursor(TuioCursor tcur)      //called when a finger is placed on the table
{
  cursor_added = tcur.getCursorID();
  //println("Cursor " + cursor_added + " added.");
  
  float x = tcur.getX() * width;
  float y = tcur.getY() * height;
 
 /* 
  if (dist(helpX, helpY, x, y) < 100 && !help) help = true;        //if touch is near help, and help is NOT true, make help true
  else if (dist(helpX, helpY, x, y) < 100 && help) help = false;   //if touch is near help, and help IS true, make help false 
*/
 
  
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
  redraw();
}
  
  
  
  
  
  

void draw()
{
  background(bg);  
  noCursor();  //hide cursor
  if (justLoaded) image(splash, (width / 2) - (splashWidth / 2), (height / 2) - (splashHeight / 2));  //if program has just loaded (ie: no pucks have been placed), centre and draw splash image
  if (help) help();
/*
  if (help)
  {
    fill(255, 255, 0);
    ellipse(helpX, helpY, 75, 75);
  }
*/
  
/*  
  image(help_icon, helpX - 25, helpY - 25);  //draw icons
  image(piano_icon, pianoX - 25, pianoY - 25);
*/
  
/*
  if (sine) sine(sineX, sineY, sineAngle);                  
  if (sawtooth) sawtooth(sawtoothX, sawtoothY, sawtoothAngle);    //IF (NOT else if) because sometimes multiple objects are on
*/
  
/*  if (help) help();
  
    if (help)
  {
    fill(255);
    rect(mouseX - 2, mouseY - 2, 4, 4);
  }
*/
  drawConnectors();
  drawPucks();
  
  if (flash) flash();  //if necessary, call methods to flash screen
}








void mousePressed()
{
  int x = mouseX;    //allows acces to help menu using mouse, just incase ;)
  int y = mouseY;
  
  saveFrame("screenshots/screenshot-###.png");  //take screenshot
  flash = true; //flash screen to show screenshot has been taken

/*  
  if (dist(helpX, helpY, x, y) < 100 && !help) help = true;        //if touch is near help, and help is NOT true, make help true
  else if (dist(helpX, helpY, x, y) < 100 && help) help = false;   //if touch is near help, and help IS true, make help false 
*/
}






/*  void mousePressed()         ***EXAMPLE OF HOW TO SEND A MESSAGE***
    {    
      OscMessage myOscMessage = new OscMessage("/location"); //CREATE an instance of OscMessage, with address pattern of /location -- Pd uses OSCroute separate by their patterns. patterns always begin with a /, otherwise they ignored by OSCroute
      myOscMessage.add((int) mouseX);  //add values to message
      myOscMessage.add((int) mouseY);
  
      oscP5.send(myOscMessage, myRemoteLocation); //VERY IMPORTANT - send message using oscP5.send(OscMessage, NetAddress) 
  
      mouseDown = true;
    }
*/



void oscEvent(OscMessage recievedMessage) //CALLED WHEN AN OSC MESSAGE IS RECIEVED
{
  println("Recieved a message: ");
  recievedMessage.print();
}
