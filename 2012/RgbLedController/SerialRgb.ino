/* Serial controlled RGB lamp
 *
 * takes input in the form X###, where X is the letter of the colour and ### is it's decimal value
 * other characters are ignored and each colour is processed seperately, e.g.
 * R127, G100, B255  =   r127 g100 b255  =  g100, r127 B255
 * r0, b255, g255  =  G255 B255 etc
 *
 */

const int RED_PIN = 9;
const int GREEN_PIN = 10;
const int BLUE_PIN = 11;

char buffer[20];  //make a char array to temporarily store serial data in (slightly longer than needed to avoid overflow)
                  //chars are weird in C and C++; you don't need to write char[] as char is already assumed to be an array

void setup() {
  Serial.begin(9600);  //starts serial comms at 9600 baud
  Serial.flush();      //flush (clear / wait for outgoing transmission to end) serial channel
  
  pinMode(RED_PIN, OUTPUT);
  pinMode(GREEN_PIN, OUTPUT);
  pinMode(BLUE_PIN, OUTPUT);
  
  digitalWrite(RED_PIN, HIGH);
  digitalWrite(GREEN_PIN, HIGH);
  digitalWrite(BLUE_PIN, HIGH);
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
    
    /* this is syntactically identical to:
         while (nChar--) buffer[i++] = Serial.read();
     * as the values of nChar and i would be changed _after_ they had been used
     * cf. --nChar and ++i which would increment/decrement them _beforehand_
     */
     
     splitString(buffer);             //call method to process the buffer data
  }
}

void splitString(char* data) {                       //in C and C++ it is illegal to send a char array to a function, so we _convert to_ a pointer instead
  //Serial.print("Received: ");
  //Serial.println(data);
                                                     //pointer again so that we can use it to access *data (must be same type)
  char* parameter;                                   //note that the * is actually attached to the variable name:
                                                     //char *data, in the same way that char &data would be used to refer to the location but not value of data
  parameter = strtok(data, " ,;");                   //parse the buffer data returning the parameters as separated by semicolons, commas or spaces
  while (parameter != NULL) {                        //keep parsing until no more parameters are returned
    setLed(parameter);                               //set the LED based on the parameter read
    parameter = strtok(NULL, " ,;");                 //parse from where left off on last string
  }
  
  for (int i = 0; i < 16; i++) buffer[i] = '\0';     //set every char in the text buffer to NULL
  //Serial.println("");
  Serial.flush();                                    //flush the serial buffer
}

void setLed(char* data) {
  if (data[0] == 'r' || data[0] == 'R') {            //if parameter begins with an R, use it to set red brightness
    int brightness = strtol(data+1, NULL, 10);       //read from second character of *data (to ignore the R)
    brightness = constrain(brightness, 0, 255);      //if >255, make 255; if <0, make 0
    
    analogWrite(RED_PIN, 255-brightness);
    //Serial.print("Set red to: ");
    //Serial.println(brightness);
  }
  
  if (data[0] == 'g' || data[0] == 'G') {            //same for green...
    int brightness = strtol(data+1, NULL, 10); 
    brightness = constrain(brightness, 0, 255); 
    
    analogWrite(GREEN_PIN, 255-brightness);
    //Serial.print("Set green to: ");
    //Serial.println(brightness);
  }
  
  if (data[0] == 'b' || data[0] == 'B') {            //...and blue
    int brightness = strtol(data+1, NULL, 10);
    brightness = constrain(brightness, 0, 255);
    
    analogWrite(BLUE_PIN, 255-brightness);
    //Serial.print("Set blue to: ");
    //Serial.println(brightness);
  }
}
