final int totalListLength = 10;
final int randomLimit = 1000;

PFont numberFont;

int[] storedList, duplicateList;
int unsortedListLength, nSwaps, nPasses, nComparisons;

//SETUP
void setup() {
  size(960, 445);
  background(0);
  frameRate(5);
  smooth();
  noStroke();

  numberFont = loadFont("LucidaSans-20.vlw");
  textFont(numberFont);
  textAlign(RIGHT);

  storedList = new int[totalListLength];              //make a permanent list to display
  duplicateList = new int[totalListLength];           //make a temporary list to use for comparisons
  
  unsortedListLength = totalListLength;               //at the start, the entire list is unsorted
  nSwaps = 0;                                         //start performance counters
  nPasses = 0;
  nComparisons = 0;

  for (int i = 0; i < totalListLength; i++) {
    storedList[i] = (int) random(randomLimit);        //randomly generate values for permanent list
    
    float linearIntensity = (float) storedList[i] / randomLimit;          //colour the numbers according to their values
    float logIntensity = ( pow(2.5, linearIntensity) - 1) / (2.5 - 1);    //convert linear intensities to log ones to make perception linear
    fill(255, 255-(logIntensity*100), 255-(logIntensity*255));
    text(storedList[i], 90, 30*i+70);
  }
  
  displayInfo();
}

//MAKE A PASS
void draw() {
  if (unsortedListLength > 1) {                        //as long as the unsorted part is more than one number,
    for (int i = 0; i < totalListLength; i++) {
      duplicateList[i] = storedList[i];                //make a copy of the current list
    }
    
    int swapsThen = nSwaps;
    
    for (int i = 0; i < unsortedListLength-1; i++) {   //step through and compare lists
      if (duplicateList[i] > storedList[i+1]) {        //if one number is greater than the number below it,
        swap(i, i+1);                                  //swap them round
        nSwaps++;                                      //record that a swap has been made
      }
      
      nComparisons++;                                  //record that a comparison has been made
    }
    
    if (nSwaps == swapsThen) unsortedListLength = 0;   //if no swaps were made, then the whole list is sorted
    else unsortedListLength--;                         //otherwise, the bottom part of the list has now been sorted
    
    nPasses++;                                         //record that a pass has been made
    display();                                         //update the screen
  }
  //else stop();
 
  displayInfo();                                       //draw bottom section
}

//SWAP
void swap(int indexOne, int indexTwo) {
  int valueOne = duplicateList[indexOne];              //record the values to swap
  int valueTwo = duplicateList[indexTwo];
  duplicateList[indexOne] = valueTwo;                  //switch them round
  duplicateList[indexTwo] = valueOne;
}

//SAVE AND WRITE NEW LIST TO SCREEN
void display() {
  for (int i = 0; i < totalListLength; i++) {
    storedList[i] = duplicateList[i];
    
    float linearIntensity = (float) storedList[i] / randomLimit;          //colour the numbers according to their values
    float logIntensity = ( pow(2.5, linearIntensity) - 1) / (2.5 - 1);    //convert linear intensities to log ones to make perception linear
    fill(255, 255-(logIntensity*100), 255-(logIntensity*255));
    textAlign(RIGHT);
    text(storedList[i], 90*(nPasses+1), 30*i+70);
  }
}

//MOUSE INPUT
void mousePressed() {
  reset();                                             //reset on mouse press
}

//RESET
void reset() {
  background(0);                             //clear screen
  for (int i = 0; i < totalListLength; i++) {
    storedList[i] = (int) random(randomLimit);         //make a new random list
    
    float linearIntensity = (float) storedList[i] / randomLimit;          //colour the numbers according to their values
    float logIntensity = ( pow(2.5, linearIntensity) - 1) / (2.5 - 1);    //convert linear intensities to log ones to make perception linear
    fill(255, 255-(logIntensity*100), 255-(logIntensity*255));
    textAlign(RIGHT);
    text(storedList[i], 90, 30*i+70);
  }
  
  nSwaps = 0;                                          //reset counters
  nPasses = 0;
  nComparisons = 0;
  unsortedListLength = totalListLength;
  
  displayInfo();
}

//DRAW BOTTOM SECTION
void displayInfo() {
  fill(50);
  rect(0, 400, width, height-400);
  fill(255);
  textAlign(LEFT);
  text("Passes: " + nPasses + "       Comparisons: " + nComparisons + "       Swaps: " + nSwaps, 50, 430);
}
