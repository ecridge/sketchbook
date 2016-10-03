//tab for managing wave generators

void sine(float sineX, float sineY, float sineAngle)
{  
  stroke(255);
  line(width / 2, height / 2, sineX * width, sineY * height);
  noStroke();
  pushMatrix();                               //INDEPENDENT MATRIX FOR ROTATION
  translate(sineX * width, sineY * height);   //SET PIVOT POINT TO OBJECT'S LOCATION
  rotate(TWO_PI - sineAngle + PI);            //ROTATE             !!!!!!!!!!!!!!!!!!!!([TWO_PI - angle] to invert direction - table is facing computer, so acts like a mirror)  ([+ PI] to correct upside-down-ness (180 degree flip)!!!!!!!!!!!!!!!!!!!!
  image(sine_image, -50, -50);                //IMPORTANT: -50 to centre image on point (image is 100x100 so 100 / 2 = 50)
  fill(255);
  ellipse(0, -70, 10, 10);           //Orientation blob over puck image
  popMatrix();                                //LEAVE MATRIX
  
  float distance = 1 - (dist(width / 2, height / 2, sineX * width, sineY * height) / (width / 2)); //gets distance between screen centre and object: divide by half screen width to get a value between 0 and 1. 1 - value inverts it (greater closer to centre)
  //println(distance);
  
  //println("Sine rotation (0 - " + TWO_PI + "): " + sineAngle);
  
  int sineValue;
  if (sine) sineValue = 1;    //create integer version of boolean
  else sineValue = 0;
  
  float adjustedRotation = (TWO_PI - sineAngle) / TWO_PI;           //((corrected yet upside-down rotation) / TWO_PI) + PI  gives a value between 0 and 1 (for Pd)
  
  OscMessage myOscMessage = new OscMessage("/sine"); //CREATE an instance of OscMessage, with address pattern of "/send" -- Pd uses OSCroute separate by their patterns. patterns always begin with a /, otherwise they ignored by OSCroute
  if (tonic_sine) myOscMessage.add(tonic_freq); //PITCH - send tonic value if near, else, send own value
  else myOscMessage.add(adjustedRotation * 1000);      //PITCH - *1000 to make audible (originally between 0 and 1)
  myOscMessage.add(sineValue * distance);  //set volume to distance from centre (closer = louder). multiply by sine (0 or 1) to ensure sound should be on
  oscP5.send(myOscMessage, myRemoteLocation); //SEND MESSAGE TO PD
}







void sawtooth(float sawtoothX, float sawtoothY, float sawtoothAngle)
{
  stroke(255);
  line(width / 2, height / 2, sawtoothX * width, sawtoothY * height);
  noStroke();
  pushMatrix();
  translate(sawtoothX * width, sawtoothY * height);
  rotate(TWO_PI - sawtoothAngle + PI);
  image(sawtooth_image, -50, -50);  //IMPORTANT: -50 to centre image on point (image is 100x100 so 100 / 2 = 50)
  fill(255);
  ellipse(0, -70, 10, 10);        //Orientation blob over puck image
  popMatrix();
  
  float distance = 1 - (dist(width / 2, height / 2, sawtoothX * width, sawtoothY * height) / (width / 2)); //gets distance between screen centre and object
  
  //println("Sawtooth rotation (0 - " + TWO_PI + "): " + sawtoothAngle);
  
  int sawtoothValue;
  if (sawtooth) sawtoothValue = 1;    //create integer version of boolean
  else sawtoothValue = 0;
  
  float adjustedRotation = (TWO_PI - sawtoothAngle) / TWO_PI;
  
  OscMessage myOscMessage = new OscMessage("/sawtooth");
  if (tonic_sawtooth) myOscMessage.add(tonic_freq); //PITCH - send tonic value if near, else, send own value
  else myOscMessage.add(adjustedRotation * 1000);      //PITCH
  myOscMessage.add(sawtoothValue * distance);  //VOLUME
  oscP5.send(myOscMessage, myRemoteLocation);
}






void square(float squareX, float squareY, float squareAngle)
{
  stroke(255);
  line(width / 2, height / 2, squareX * width, squareY * height);
  noStroke();
  pushMatrix();
  translate(squareX * width, squareY * height);
  rotate(TWO_PI - squareAngle + PI);
  image(square_image, -50, -50);  //IMPORTANT: -50 to centre image on point (image is 100x100 so 100 / 2 = 50)
  fill(255);
  ellipse(0, -70, 10, 10);      //Orientation blob over puck image
  popMatrix();
  
  float distance = 1 - (dist(width / 2, height / 2, squareX * width, squareY * height) / (width / 2)); //gets distance between screen centre and object
  
  //println("Square rotation (0 - " + TWO_PI + "): " + squareAngle);
  
  int squareValue;
  if (square) squareValue = 1;    //create integer version of boolean
  else squareValue = 0;
  
  float adjustedRotation = (TWO_PI - squareAngle) / TWO_PI;
  
  OscMessage myOscMessage = new OscMessage("/square");
  if (tonic_square) myOscMessage.add(tonic_freq); //PITCH - send tonic value if near, else, send own value
  else myOscMessage.add(adjustedRotation * 1000);      //PITCH
  myOscMessage.add(squareValue * distance);  //VOLUME
  oscP5.send(myOscMessage, myRemoteLocation);
}






void wNoise(float wNoiseX, float wNoiseY)
{
  stroke(255);
  line(width / 2, height / 2, wNoiseX * width, wNoiseY * height);
  noStroke();
  image(noise_image, (wNoiseX * width) - 50, (wNoiseY * height) - 50);
  
  float distance = 1 - (dist(width / 2, height / 2, wNoiseX * width, wNoiseY * height) / (width / 2));
  
  int wNoiseValue;
  if (wNoise) wNoiseValue = 1;    //create integer version of boolean
  else wNoiseValue = 0;
  
  OscMessage myOscMessage = new OscMessage("/noise");
  //myOscMessage.add(adjustedRotation);      //FILTER? - NOT YET
  myOscMessage.add(wNoiseValue * distance);  //VOLUME
  oscP5.send(myOscMessage, myRemoteLocation);
}
