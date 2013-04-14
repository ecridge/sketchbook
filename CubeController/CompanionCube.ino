/* Illuminates companion cube model with 3 color LED.
 * LDR included for interactivity.
 *
 * Cube color oscillates with an amplitude that is
 * dependent on its frequency.
 *
 * Cridge 04.13
 */

const int RED_PIN = 9;
const int GREEN_PIN = 10;
const int BLUE_PIN = 11;

const int LDR_PIN = A0;

char buffer[20];

const int OFF = 0;
const int STORAGE = 1;
const int ACTIVE = 2;
const int COMPANION = 3;
const int DISTRESS = 4;
const int SLOW = 5;
const int MED = 6;
const int FAST = 7;
const int SPEED = 8;

int amplitude, pace, mode;
int ldrValue, oscValue;

void setup() {
  Serial.begin(9600);
  Serial.flush();
  
  pinMode(RED_PIN, OUTPUT);
  pinMode(GREEN_PIN, OUTPUT);
  pinMode(BLUE_PIN, OUTPUT);
  
  digitalWrite(RED_PIN, HIGH);
  digitalWrite(GREEN_PIN, HIGH);
  digitalWrite(BLUE_PIN, HIGH);
  
  ldrValue = 255;
  amplitude = 62;     //between 1 and 100 (0 gives constant magenta)
  pace = 50;          //between 1 and 100 (0 gives constant magenta)
  mode = 0;           //wait for command before turning on
}

void loop() {
  //COPY ANY INCOMING TRANSMISSION TO BUFFER
  if (Serial.available() > 0) {       //if there any characters/bytes have been received
    delay(100);                       //give some time for the board's buffer to fill
    int nChar = Serial.available();   //record how many chars are availible
    if (nChar >= 16) nChar = 16;      //if there are more than 16 chars, only read the first 16
    
    int i = 0;                        //copy incoming transmission to our buffer:
    while (nChar) {                   //whilst nChar > 0
      buffer[i] = Serial.read();      //record the first incoming byte (as a char)
      nChar--;                        //iterate through all incoming bytes (up to 16)
      i++;
    }
  
    //DEAL WITH SERIAL INPUT  
    char* parameter;
  
    parameter = strtok(buffer, " ,;");                 //parse the buffer data returning the parameters as separated by semicolons, commas or spaces
    while (parameter != NULL) {                        //keep parsing until no more parameters are returned
      updateCube(parameter);                           //use separated paramaters to update cube
      parameter = strtok(NULL, " ,;");                 //parse from where left off on last string
    }
  
    for (int i = 0; i < 16; i++) buffer[i] = '\0';     //set every char in the text buffer to NULL
    Serial.flush();                                    //flush the serial buffer
  }  
  
  //RUN THE CUBE
  if (mode >= SLOW) {
    oscillate();
  }
  else if (mode == DISTRESS) {
    alternate();
  }
  else { 
    //do nothing
  }
}

void updateCube(char* data) {
  if (data[0] == 's' || data[0] == 'S') {
    mode = SPEED;
    
    int happiness = strtol(data+1, NULL, 10);
    happiness = constrain(happiness, 0, 100);
    pace = happiness;
    amplitude = calculateAmplitude(happiness);
  }
  else if (data[0] == 'm' || data[0] == 'M') {
    mode = strtol(data+1, NULL, 10);
    mode = constrain(mode, OFF, SPEED);
    
    switch (mode) {    //initialise new mode if necessary
      case OFF:
        digitalWrite(RED_PIN, HIGH);
        digitalWrite(GREEN_PIN, HIGH);
        digitalWrite(BLUE_PIN, HIGH);
      break;
      case STORAGE:
        digitalWrite(RED_PIN, HIGH);
        digitalWrite(GREEN_PIN, LOW);
        digitalWrite(BLUE_PIN, LOW);
      break;
      case ACTIVE:
        analogWrite(RED_PIN, 135);
        digitalWrite(GREEN_PIN, LOW);
        digitalWrite(BLUE_PIN, HIGH);
      break;
      case COMPANION:
        digitalWrite(RED_PIN, LOW);
        analogWrite(GREEN_PIN, 100);
        digitalWrite(BLUE_PIN, LOW);
      break;
      case DISTRESS:
        pace = 20;
      break;
      case SLOW:
        digitalWrite(BLUE_PIN, LOW);
        pace = 8;
        amplitude = calculateAmplitude(pace);
      break;
      case MED:
        digitalWrite(BLUE_PIN, LOW);
        pace = 40;
        amplitude = calculateAmplitude(pace);
      break;
      case FAST:
        digitalWrite(BLUE_PIN, LOW);
        pace = 90;
        amplitude = calculateAmplitude(pace);
      break;
      case SPEED:
        digitalWrite(BLUE_PIN, LOW);
        //SPEED mode should be called using "S<speed 0-100>"
        //in the case where it is called by "M8", the following defaults will be used
        pace = 50;
        amplitude = calculateAmplitude(pace);
      break;
    }
  }
  else {
    //do nothing
  }
} 

int calculateAmplitude(int newPace) {
  int newAmplitude;
  float tempVar = 104.2 - 0.842*newPace;
  tempVar = constrain(tempVar, 20.0, 100.0);
  newAmplitude = int(tempVar);
  return newAmplitude;
}
  
//Oscillates between blue and white through magenta  
void oscillate() {
  oscValue = int(amplitude*2.55*sin(radians(millis()*(pace/50.0))));
  
  if (oscValue >= 0) {
    digitalWrite(RED_PIN, LOW);
    analogWrite(GREEN_PIN, 255-oscValue);
  }
  else {
    digitalWrite(GREEN_PIN, HIGH);
    analogWrite(RED_PIN, -oscValue);
  }
}

//Alternates between blue and amber
void alternate() {
  oscValue = int(255*sin(radians(millis()*(pace/50.0))));
  
  if (oscValue >= 0) {
    analogWrite(RED_PIN, 135);
    digitalWrite(GREEN_PIN, LOW);
    digitalWrite(BLUE_PIN, HIGH);
  }
  else {
    digitalWrite(RED_PIN, HIGH);
    digitalWrite(GREEN_PIN, LOW);
    digitalWrite(BLUE_PIN, LOW);
  }
}
