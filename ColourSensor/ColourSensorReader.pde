/* 
 * Reads the raw input from arduino RGB/LDR colour
 * sensor (0-255 uncalibrated).
 *
 * Program adjusts input and draws colour to screen.
 * Calculated hue is also drawn, though this does not
 * currently display correctly for yellowy colours, and
 * should also be ignored as brightness approaches 0 or
 * 100%, at which point it is technically undefined.
 */
 
import processing.serial.*;
Serial arduinoPort;
 
PFont infoFont;
int[] raw, calibrated;            //colours are stored in an array, where [0]=red, [1]=green and [2]=blue
int[] black = { 37, 22, 15 };     //the raw colour values read for known colour samples (used for calibration)
int[] white = { 106, 65, 36 };

int hueValue, brightnessValue;    //hue is important as it is independent of brightness
String received;
 
void setup() {
  size(580, 300);
  background(255);
  frameRate(15);
  smooth();
  infoFont = loadFont("infoFont.vlw");
  textFont(infoFont);
  
  String portName = Serial.list()[6];
  arduinoPort = new Serial(this, portName, 9600);
  
  raw = new int[3];
  calibrated = new int[3];
}

void draw() {
  background(255);
  
  noStroke();
  fill(0);
  textAlign(LEFT);
  text("Raw value:", 40, 40);
  text("Calibrated:", 220, 40);
  text("Hue:", 400, 40);
  textAlign(RIGHT);
  text("(" + raw[0] + ", " + raw[1] + ", " + raw[2] + ")", 180, 72);
  text("(" + calibrated[0] + ", " + calibrated[1]+ ", " + calibrated[2] + ")", 360, 72);
  text(hueValue + "º", 540, 72);
  
  stroke(0);
  fill(raw[0], raw[1], raw[2]);
  rect(40, 120, 140, 140);
  fill(calibrated[0], calibrated[1], calibrated[2]);
  rect(220, 120, 140, 140);
  colorMode(HSB, 1.0);
  fill(hueValue/360.0, 1.0, 0.5);
  rect(400, 120, 140, 140);
  colorMode(RGB, 255);
}

void mousePressed() {
  arduinoPort.write("read");
  delay(300);
  
  if (arduinoPort.available() > 0) {
    received = String.valueOf(arduinoPort.readString());
    arduinoPort.clear();
    
    String[] splits = received.split(" ");
    raw[0] = Integer.parseInt(splits[0]);
    raw[1] = Integer.parseInt(splits[1]);
    raw[2] = Integer.parseInt(splits[2].substring(0, splits[2].length()-2));  //cuts off the tailing space
    
    for (int i = 0; i < 3; i++) {
      raw[i] = constrain(raw[i], black[i], white[i]);
      calibrated[i] = (int) map(raw[i], black[i], white[i], 0, 255);
    }
    
    brightnessValue = int( (calibrated[0] + calibrated[1] + calibrated[2]) / 3.0 );
    println(brightnessValue);
    
    float f;
    f = atan2( sqrt(3.0) * (calibrated[1] - calibrated[2]), (2.0 * calibrated[0]) - (calibrated[1] + calibrated[2]) );
    f = degrees(f);
    hueValue = (int) f;
    if (hueValue < 0) {
      hueValue += 360;        //convert from range -180 -> 180 to range 0 -> 360
    }
  }
}
