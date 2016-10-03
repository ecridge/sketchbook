import oscP5.*;  //import oscP5 library
import netP5.*;

OscP5 oscP5;  //DEFINE an OscP5 object (called oscP5)
NetAddress myRemoteLocation; //the NetAddress contains the IP and port number

int number, i;

void setup()
{
  size(400, 400);
  background(255);
  noStroke();
  smooth();
  frameRate(10);
  oscP5 = new OscP5(this, 12000);  //CREATE the instance of the OscP5 object (oscP5) - listening on port 12000
  myRemoteLocation = new NetAddress("127.0.0.1", 12001); //CREATE the NetAddress object - SENDING on port 12001 (recursive IP: 127.0.0.1 = localhost)
  
  number = (int) random(10000);
  i = 0;
}

void draw()
{  
  i++;
  fill(0, 255 - i, 0, 10);
  rect(0, 400 - (number / 100), 400, 4000);
  
  if (number == 1)  //if end loop is reached...
  {
    number = 0;
  }
  else if (number % 2 == 0)  //if number is even...
  {
    number /= 2; 
  }
  else  //if number is odd...
  {
    number *= 3;
    number += 1;
  }
  
  OscMessage myOscMessage = new OscMessage("/pitch");
  myOscMessage.add(number);
  oscP5.send(myOscMessage, myRemoteLocation);
}

void mousePressed()
{
  background(255);
  i = 0;
  number = (int) random(10000);
}

void oscEvent(OscMessage recievedMessage) //CALLED WHEN AN OSC MESSAGE IS RECIEVED
{
  println("Recieved a message: ");
  recievedMessage.print();
}
