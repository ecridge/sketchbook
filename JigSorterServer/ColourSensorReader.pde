class ColourSensorReader {
  Serial port;
  String received;
  PFont font;
  float[] raw, calibrated, black, white;        //colours are stored in an array, where [0]=red, [1]=green and [2]=blue
  float hueValue, brightnessValue;              //hue is important as it is independent of brightness
  color rawColor, calibColor;

  ColourSensorReader(Serial sensorPort, color blackPoint, color whitePoint, PFont font_) {
    raw = new float[3];
    calibrated = new float[3];
    black = new float[3];
    white = new float[3];
    setBlackPoint(blackPoint);
    setWhitePoint(whitePoint);
    
    rawColor = color(0, 0, 0);
    calibColor = color(0, 0, 0);
    
    font = font_;
    port = sensorPort;
  }
  
  void read() {
    port.write("read");
    delay(300);
    
    if (port.available() > 0) {
      received = String.valueOf(port.readString());
      port.clear();
      
      String[] splits = received.split(" ");
      raw[0] = Float.parseFloat(splits[0]);
      raw[1] = Float.parseFloat(splits[1]);
      raw[2] = Float.parseFloat(splits[2].substring(0, splits[2].length()-2));  //cuts off the tailing space
      
      for (int i = 0; i < 3; i++) {
        raw[i] = constrain(raw[i], black[i], white[i]);
        calibrated[i] = map(raw[i], black[i], white[i], 0.0, 255.0);
      }
      
      rawColor = color(raw[0], raw[1], raw[2]);
      calibColor = color(calibrated[0], calibrated[1], calibrated[2]);
      
      brightnessValue = (calibrated[0] + calibrated[1] + calibrated[2]) / 3.0;
      
      float f;
      f = atan2( sqrt(3.0) * (calibrated[1] - calibrated[2]), (2.0 * calibrated[0]) - (calibrated[1] + calibrated[2]) );
      f = degrees(f);
      hueValue = f;
      if (hueValue < 0.0) {
        hueValue += 360.0;        //convert from range -180 -> 180 to range 0 -> 360
      }
    }
  }
  
  void displayReading() {       //requires 580*240 pixels
    textFont(font);
  
    stroke(0);
    fill(200);
    rect(0, 0, 580, 240);
    noStroke();
    fill(0);
    textAlign(LEFT);
    text("Raw value:", 40, 40);
    text("Calibrated:", 220, 40);
    text("Hue:", 400, 40);
    textAlign(RIGHT);
    text("#" + hex(rawColor, 6), 180, 222);
    text("#" + hex(calibColor, 6), 360, 222);
    if (brightnessValue <= unsortedThreshold || brightnessValue >= whiteThreshold) {
      text("-", 540, 222);
    }
    else {
      text(int(hueValue+0.5) + "º", 540, 222);
    }
    
    stroke(0);
    fill(raw[0], raw[1], raw[2]);
    rect(40, 60, 140, 140);
    fill(calibrated[0], calibrated[1], calibrated[2]);
    rect(220, 60, 140, 140);
    if (brightnessValue <= unsortedThreshold) {
      fill(0, 0, 0);
      rect(400, 60, 140, 140);
    }
    else if (brightnessValue >= whiteThreshold) {
      fill(255, 255, 255);
      rect(400, 60, 140, 140);
    }
    else {
      colorMode(HSB, 1.0);
      fill(hueValue/360.0, 1.0, 1.0);
      rect(400, 60, 140, 140);
      colorMode(RGB, 255);
    }
  }
  
  void setBlackPoint(color blackPoint) {
    black[0] = red(blackPoint);
    black[1] = green(blackPoint);
    black[2] = blue(blackPoint);
  }
  
  void setWhitePoint(color whitePoint) {
    white[0] = red(whitePoint);
    white[1] = green(whitePoint);
    white[2] = blue(whitePoint);
  }
  
  float getHue() {
    return hueValue;
  }
  
  float getBrightness() {
    return brightnessValue;
  }
  
  color getCalibrated() {
    return calibColor;
  }
  
  color getRaw() {
    return rawColor;
  }
}
