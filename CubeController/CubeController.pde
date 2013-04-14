import processing.serial.*;

Serial arduinoPort;
Panel[][] grid;

String[] names = { 
  "Off", "Storage\n Cube", "Activated\n Cube", "Companion\n Cube", "Distress\n Signal", "Slow Pulse", "Medium Pulse", "Fast Pulse"
};
String[] iconNames = { 
  "off.png", "storage.png", "active.png", "companion.png", "distress_storage.png", "slow.png", "medium.png", "fast.png"
};

int gridWidth = 4;
int gridHeight = 2;
int selected, serialPort;

void setup() {
  size(590, 390);
  background(150);
  smooth();
  frameRate(30);
  
  connectToCube();

  int k = 0;
  grid = new Panel[gridHeight][gridWidth];
  for (int i = 0; i < gridHeight; i++) {
    for (int j = 0; j < gridWidth; j++) {
      PImage icon = loadImage(iconNames[k]);
      grid[i][j] = new Panel(k, j*145+10, i*190+10, icon, names[k]);
      k++;
    }
  }
  
  arduinoPort.write("M0");    //start serial control, causing cube to restart into *its* default, regardless of message
  selected = 0;               //match startup slection to cube default
  
  long timeMark = millis();
  while (millis ()-timeMark <= 500) {
    //wait for cube to restart
  }
}

void draw() {
  background(150);

  for (int i = 0; i < gridHeight; i++) {
    for (int j = 0; j < gridWidth; j++) {
      grid[i][j].display();
    }
  }
}

void mousePressed() {
  for (int i = 0; i < gridHeight; i++) {
    for (int j = 0; j < gridWidth; j++) {
      if ( grid[i][j].check() ) {
        selected = grid[i][j].getId();
      }
    }
  }
  
  update();
}


void keyPressed() {
  boolean changed;
  
  if (keyCode == UP) {
    if (selected >= 4) {
      selected -= 4;
      changed = true;
    }
    else {
      changed = false;
    }
  }
  else if (keyCode == DOWN) {
    if (selected <= 3) {
      selected += 4;
      changed = true;
    }
    else {
      changed = false;
    }
  }
  else if (keyCode == LEFT) {
    if (selected != 0 && selected != 4) {
      selected -= 1;
      changed = true;
    }
    else {
      changed = false;
    }
  }
  else if (keyCode == RIGHT) {
    if (selected != 3 && selected != 7) {
      selected += 1;
      changed = true;
    }
    else {
      changed = false;
    }
  }
  else {
    changed = false;
  }
  
  if (changed) {
    update();
  }
}

void update() {
  long timeMark = millis();
  while (millis ()-timeMark <= 100) {
    //wait 100ms to avoid overloading buffer
  }
  String stringToSend = "M" + selected;    //set mode
  arduinoPort.write(stringToSend);
}

void connectToCube() {
  serialPort = -1;
  for (int i = 0; i < Serial.list().length; i++) {
    if (Serial.list()[i].equals("/dev/tty.usbmodemfd131")) {
      serialPort = i;
    }
  }
  if (serialPort >= 0) {
    String portName = Serial.list()[serialPort];    //Use ListSerial.app to find port number
    arduinoPort = new Serial(this, portName, 9600);
  }
  else {
    exit();
  }
}
