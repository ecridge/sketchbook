/* Senses colour by shining red, green then blue
 * light on a sample and recording the corresponding
 * reflected light level.
 * 
 * Raw colour values are sent via serial to be
 * interpreted.
 */
 
const int RED_PIN = 9;
const int GREEN_PIN = 10;
const int BLUE_PIN = 11;
const int LDR_PIN = 0;

int redValue, greenValue, blueValue;
char buffer[10];

void setup() {
  pinMode(RED_PIN, OUTPUT);
  pinMode(GREEN_PIN, OUTPUT);
  pinMode(BLUE_PIN, OUTPUT);
  
  digitalWrite(RED_PIN, HIGH);
  digitalWrite(GREEN_PIN, HIGH);
  digitalWrite(BLUE_PIN, HIGH);
  
  Serial.begin(9600);
  Serial.flush();
}
 
void loop() {
  if (Serial.available() > 0) {          //will only call the scan function if "read" is received
    delay(100);
    
    int nChar = Serial.available();
    if (nChar >= 4) {
      nChar = 4;
    }
    
    int i = 0;
    while (nChar--) {
      buffer[i++] = Serial.read();
    }
    
    evaluate(buffer);
  }
} 
 
void evaluate(char* data) {
  if (data[0] == 'r') {
    scan();
  }
  
  for (int i = 0; i < 5; i++) {
    buffer[i] = '\0';
  }
  
  Serial.flush();
}
 
void scan() {
  digitalWrite(RED_PIN, LOW);
  delay(50);
  redValue = reduceToByte(analogRead(LDR_PIN));
  digitalWrite(RED_PIN, HIGH);
  
  digitalWrite(GREEN_PIN, LOW);
  delay(50);
  greenValue = reduceToByte(analogRead(LDR_PIN));
  digitalWrite(GREEN_PIN, HIGH);
  
  digitalWrite(BLUE_PIN, LOW);
  delay(50);
  blueValue = reduceToByte(analogRead(LDR_PIN));
  digitalWrite(BLUE_PIN, HIGH);
  
  Serial.print(redValue);
  Serial.print(" ");
  Serial.print(greenValue);
  Serial.print(" ");
  Serial.println(blueValue);
}

int reduceToByte(int value) {
  float fValue = float(value);
  float prop = (255.0*fValue)/1023.0;
  prop = constrain(prop, 0.0, 255.0);
  prop += 0.5;
  return int(prop);
}
