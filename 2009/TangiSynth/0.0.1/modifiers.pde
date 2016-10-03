void tonic(float tonicX, float tonicY, float tonicAngle)  //TONIC SELECTOR, WHEN PLACED NEAR TO A WAVE OBJECT, SETS THE TONIC/KEY FOR THAT OBJECT (C, C#, D ... B).  OTHER MODIFIERS THEN CONNECT TO THE TONIC SELECTOR INSTEAD
{
  if (sine && dist(tonicX * width, tonicY * height, sineX * width, sineY * height) < 300)
  {
    //println("Sine is close to Tonic Selector");
    tonic_sine = true;
    stroke(15, 0, 135);
    line(tonicX * width, tonicY * height, sineX * width, sineY * height);
    noStroke();
  }
  else tonic_sine = false;
  
  if (sawtooth && dist(tonicX * width, tonicY * height, sawtoothX * width, sawtoothY * height) < 300)
  {
    //println("Sawtooth is close to Tonic Selector");
    tonic_sawtooth = true;
    stroke(15, 0, 135);
    line(tonicX * width, tonicY * height, sawtoothX * width, sawtoothY * height);
    noStroke();
  }
  else tonic_sawtooth = false;
  
  if (square && dist(tonicX * width, tonicY * height, squareX * width, squareY * height) < 300)
  {
    //println("Square is close to Tonic Selector");
    tonic_square = true;
    stroke(15, 0, 135);
    line(tonicX * width, tonicY * height, squareX * width, squareY * height);
    noStroke();
  }
  else tonic_square = false;
  
  
  pushMatrix();                                //INDEPENDENT MATRIX FOR ROTATION
  translate(tonicX * width, tonicY * height);  //SET PIVOT POINT TO OBJECT'S LOCATION
  rotate(TWO_PI - tonicAngle + PI);            //ROTATE             !!!!!!!!!!!!!!!!!!!!([TWO_PI - angle] to invert direction - table is facing computer, so acts like a mirror)  ([+ PI] to correct upside-down-ness (180 degree flip)!!!!!!!!!!!!!!!!!!!!
  image(tonic_image, -50, -50);                //IMPORTANT: -50 to centre image on point (image is 100x100 so 100 / 2 = 50)
  //ellipse(0, -70, 10, 10);                   //Orientation blob over puck image
  popMatrix();                                 //LEAVE MATRIX
  
  //println(distance);
  
  //println("Sine rotation (0 - " + TWO_PI + "): " + sineAngle);
  
  int tonicValue;
  if (tonic) tonicValue = 1;    //create integer version of boolean
  else tonicValue = 0;
  
  float adjustedRotation = (TWO_PI - tonicAngle) / TWO_PI;           //((corrected yet upside-down rotation) / TWO_PI) + PI  gives a value between 0 and 1 (for Pd)
  
  float t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12;  //THRESHLOLD VALUES - for determining tonic note from rotation
  
  t0 = 0;              //SET VALUES (TWO_PI = max rotation, 12 = number of notes)
  t1 = TWO_PI / 12;
  t2 = t1 * 2;
  t3 = t1 * 3;
  t4 = t1 * 4;
  t5 = t1 * 5;
  t6 = t1 * 6;
  t7 = t1 * 7;
  t8 = t1 * 8;
  t9 = t1 * 9;
  t10 = t1 * 10;
  t11 = t1 * 11;
  t12 = TWO_PI;
  
  if(tonicAngle >= t0 && tonicAngle < t1)
  {
    tonic_freq = 493.9;  //IN REVERSE ORDER DUE TO ROTATION DIRECTION (LOW <---> HIGH).      If tonicAngle is in the 1st 'gap', note is B.
    tonic_name = "B";
  }
  else if (tonicAngle >= t1 && tonicAngle < t2)
  {
    tonic_freq = 466.2;
    tonic_name = "A# / Bb";
  }
  else if (tonicAngle >= t2 && tonicAngle < t3)
  {
    tonic_freq = 440; 
    tonic_name = "A";
  }
  else if (tonicAngle >= t3 && tonicAngle < t4)
  {
    tonic_freq = 415.3; 
    tonic_name = "G# / Ab";
  }
  else if (tonicAngle >= t4 && tonicAngle < t5)
  {
    tonic_freq = 392; 
    tonic_name = "G";
  }
  else if (tonicAngle >= t5 && tonicAngle < t6)
  {
    tonic_freq = 370; 
    tonic_name = "F# / Gb";
  }
  else if (tonicAngle >= t6 && tonicAngle < t7)
  {
    tonic_freq = 349.2; 
    tonic_name = "F";
  }
  else if (tonicAngle >= t7 && tonicAngle < t8)
  {
    tonic_freq = 329.6; 
    tonic_name = "E";
  }
  else if (tonicAngle >= t8 && tonicAngle < t9)
  {
    tonic_freq = 311.1; 
    tonic_name = "D# / Eb";
  }
  else if (tonicAngle >= t9 && tonicAngle < t10)
  {
    tonic_freq = 293.7;
    tonic_name = "D";
  }
  else if (tonicAngle >= t10 && tonicAngle < t11)
  {
    tonic_freq = 277.2;
    tonic_name = "C# / Db";
  }
  else if (tonicAngle >= t11 && tonicAngle < t12)
  {
    tonic_freq = 261.6; 
    tonic_name = "C";
  }
  println("Tonic is " + tonic_freq + " (" + tonic_name + ").");
}
