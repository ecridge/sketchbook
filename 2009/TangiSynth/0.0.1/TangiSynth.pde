import oscP5.*;
import netP5.*;

import TUIO.*;

OscP5 oscP5;  //DEFINE an OscP5 object (called oscP5)
NetAddress myRemoteLocation; //the NetAddress contains the IP and port number

TuioProcessing tuioClient;    //define instance of TuioProcessing

PImage splash, help_icon, piano_icon, help_image;
PImage bg, sine_image, sawtooth_image, square_image, noise_image;
PImage tonic_image;

int splashWidth = 400;
int splashHeight = 300;
boolean loaded = true;

boolean help = false;    //booleans to store whether user has pressed help/piano icons
boolean piano = false;
int helpX, helpY, pianoX, pianoY; //variables to store locations of the icons

boolean sine = false;  //to tell whether specific objects are on the table
boolean sawtooth = false;
boolean square = false;
boolean wNoise = false;
boolean tonic = false;

boolean tonic_sine = false;    //to show wether tonic is close to wave object(s)
boolean tonic_sawtooth = false;
boolean tonic_square = false;

float sineX, sineY, sawtoothX, sawtoothY, squareX, squareY;  //values for storing wave pucks' locations (floats between 0 and 1)
float sineAngle, sawtoothAngle, squareAngle;  //NOTE: angles are between 0 and 6.28 (Pi * 2) because this is the way rotate accepts them!!!!!!!!!!!!!!!!!!!
float wNoiseX, wNoiseY;
float tonicX, tonicY, tonicAngle;
float tonic_freq = 261.6;
String tonic_name = "C";

void setup()
{
  //SOME CODE TO READ DESIRED RESOLUTION FROM FILE FIRST
  strokeWeight(5);  //SET STROKE THICKNESS
  size(1680, 1050);
  frameRate(30);
  bg = loadImage("images/bg_1680x1050.png");  //set background image
  splash = loadImage("images/splash.png");  //load splash screen
  help_image = loadImage("images/help.png");  //load help screen
  help_icon = loadImage("images/help_icon.png");
  piano_icon = loadImage("images/piano_icon.png");
  sine_image = loadImage("images/sine.png");  //load image for sine wave
  sawtooth_image = loadImage("images/sawtooth.png");
  square_image = loadImage("images/square.png");
  noise_image = loadImage("images/noise.png");
  tonic_image = loadImage("images/tonic.png");
  background(bg);  //paint background
  smooth();
  noStroke();
  tuioClient = new TuioProcessing(this);    //create instance of TuioProcessing
  oscP5 = new OscP5(this, 12000);  //CREATE the instance of the OscP5 object (oscP5) - listening on port 12000
  myRemoteLocation = new NetAddress("127.0.0.1", 12001); //CREATE the NetAddress object - SENDING on port 12001 (recursive IP: 127.0.0.1 = localhost)
  
  helpX = 75;
  helpY = height - 75;
  pianoX = 75;
  pianoY = height - 175;
}

int id_added, id_removed, id_updated, cursor_added, cursor_removed, cursor_updated;

void addTuioObject(TuioObject tobj)       //called when an is placed on the table
{
  id_added = tobj.getSymbolID();
  //println("Object " + id_added + " added.");
  
  if (loaded) loaded = false;  //stop displaying splash image, if it is being displayed
  
  if (id_added == 20) sine = true;
  else if (id_added == 21) sawtooth = true;
  else if (id_added == 22) square = true;
  else if (id_added == 23) wNoise = true;
  else if (id_added == 24) tonic = true;
  
  float x = tobj.getX();
  float y = tobj.getY();
  float angle = PI;  //MUST START AS PI INSTEAD AS 0 BECAUSE OF MIRROR EFFECT  
  if (id_added == 20)
  {
    sineX = x;
    sineY = 1 - y;    //1 - y CORRECTS Y AXIS INVERSION
    sineAngle = angle;
  }
  else if (id_added == 21)        //ELSE IF since only one object cane be updated at a time
  {
    sawtoothX = x;
    sawtoothY = 1 - y;
    sawtoothAngle = angle;
  }
  
  else if (id_added == 22)
  {
    squareX = x;
    squareY = 1 - y;    
    squareAngle = angle;
  }
  else if (id_added == 23)
  {
    wNoiseX = x;
    wNoiseY = 1 - y;
  }
  else if (id_added == 24)
  {
    tonicX = x;
    tonicY = 1 - y;
    tonicAngle = angle;
  }
}

void removeTuioObject(TuioObject tobj)    //called when an object is removed from the table
{
  id_removed = tobj.getSymbolID();
  //println("Object " + id_removed + " removed.");
  
  if (id_removed == 20)
  {
    sine = false;
    OscMessage myOscMessage = new OscMessage("/sine"); //CREATE an instance of OscMessage, with address pattern of "/send" -- Pd uses OSCroute separate by their patterns. patterns always begin with a /, otherwise they ignored by OSCroute
    myOscMessage.add(0);      //PITCH
    myOscMessage.add(sine);  //VOLUME add value of 0 (sine is now false)
    oscP5.send(myOscMessage, myRemoteLocation); //SEND MESSAGE TO PD
    sineAngle = PI;
  }
  else if (id_removed == 21)
  {
    sawtooth = false;
    OscMessage myOscMessage = new OscMessage("/sawtooth");
    myOscMessage.add(0);      //PITCH
    myOscMessage.add(sawtooth);  //VOLUME
    oscP5.send(myOscMessage, myRemoteLocation);
    sawtoothAngle = PI;
  }
  else if (id_removed == 22)
  {
    square = false;
    OscMessage myOscMessage = new OscMessage("/square");
    myOscMessage.add(0);      //PITCH
    myOscMessage.add(square);  //VOLUME
    oscP5.send(myOscMessage, myRemoteLocation);
    squareAngle = PI;
  }
  else if (id_removed == 23)
  {
    wNoise = false;
    OscMessage myOscMessage = new OscMessage("/noise");
    //myOscMessage.add(0);     //FILTER ([lop~] or [hip~])????? - NOT YET
    myOscMessage.add(wNoise);  //VOLUME
    oscP5.send(myOscMessage, myRemoteLocation);
  }
  else if (id_removed == 24)
  {
    tonic = false;
  }
}

void updateTuioObject(TuioObject tobj)    //called when an object is moved
{
  float x = tobj.getX();
  float y = tobj.getY();
  float angle = tobj.getAngle();
  id_updated = tobj.getSymbolID();
  //println("Object " + id_updated + " updated:   X = " + x + ";   Y = " + y);
  
  if (id_updated == 20)
  {
    sineX = x;
    sineY = 1 - y;    //1 - y CORRECTS Y AXIS INVERSION
    sineAngle = angle;
  }
  else if (id_updated == 21)        //ELSE IF since only one object can be updated at a time
  {
    sawtoothX = x;
    sawtoothY = 1 - y;
    sawtoothAngle = angle;
  }
  else if (id_updated == 22)        //ELSE IF since only one object can be updated at a time
  {
    squareX = x;
    squareY = 1 - y;
    squareAngle = angle;
  }
  else if (id_updated == 23)        //ELSE IF since only one object can be updated at a time
  {
    wNoiseX = x;
    wNoiseY = 1 - y;
  }
  else if (id_updated == 24)
  {
    tonicX = x;
    tonicY = 1 - y;
    tonicAngle = angle;
  }
}

void addTuioCursor(TuioCursor tcur)      //called when a finger is placed on the table
{
  cursor_added = tcur.getCursorID();
  //println("Cursor " + cursor_added + " added.");
  
  float x = tcur.getX() * width;
  float y = tcur.getY() * height;
  
  if (dist(helpX, helpY, x, y) < 100 && !help) help = true;        //if touch is near help, and help is NOT true, make help true
  else if (dist(helpX, helpY, x, y) < 100 && help) help = false;   //if touch is near help, and help IS true, make help false 
  
  if (dist(pianoX, pianoY, x, y) < 100 && !piano) piano = true;
  else if (dist(pianoX, pianoY, x, y) < 100 && piano) piano = false;
  
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
  if (loaded) image(splash, (width / 2) - (splashWidth / 2), (height / 2) - (splashHeight / 2));  //if program has just loaded (ie: no pucks have been placed), centre and draw splash image
  
  if (help)
  {
    fill(255, 255, 0);
    ellipse(helpX, helpY, 75, 75);
  }
  if (piano)
  {
    fill(255, 255, 0);
    ellipse(pianoX, pianoY, 75, 75);
  }
  
  
  image(help_icon, helpX - 25, helpY - 25);  //draw icons
  image(piano_icon, pianoX - 25, pianoY - 25);
  
  if (tonic) tonic(tonicX, tonicY, tonicAngle);
  if (sine) sine(sineX, sineY, sineAngle);                  
  if (sawtooth) sawtooth(sawtoothX, sawtoothY, sawtoothAngle);    //IF (NOT else if) because sometimes multiple objects are on
  if (square) square(squareX, squareY, squareAngle);
  if (wNoise) wNoise(wNoiseX, wNoiseY);
  
  if (help) help();
  else if (piano) piano();
  
    if (help)
  {
    fill(255);
    rect(mouseX - 2, mouseY - 2, 4, 4);
  }
}


void mousePressed()
{
  int x = mouseX;    //allows acces to help menu using mouse, just incase ;)
  int y = mouseY;
  
  if (dist(helpX, helpY, x, y) < 100 && !help) help = true;        //if touch is near help, and help is NOT true, make help true
  else if (dist(helpX, helpY, x, y) < 100 && help) help = false;   //if touch is near help, and help IS true, make help false 
  
  if (dist(pianoX, pianoY, x, y) < 100 && !piano) piano = true;
  else if (dist(pianoX, pianoY, x, y) < 100 && piano) piano = false;
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
