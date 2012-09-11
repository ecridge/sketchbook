void setup() {
  size(1100, 200);
  background(255);
  smooth();
  noStroke();
}

void draw() {
  background(255);
  for (int i = 0; i < 11; i++) {
    float linearProportionBrightness = i / 10.0;
    float logProportionBrightness = (pow(2.5, linearProportionBrightness) - 1) / (2.5 - 1);
    
    int linearBrightness = (int) (255*linearProportionBrightness);
    int logBrightness = (int) (255*logProportionBrightness);
    
    println(linearBrightness + " " + logBrightness);
    
    fill(linearBrightness);
    rect(i*100, 0, 100, 100);
    
    fill(logBrightness);
    rect(i*100, 100, 100, 100);
  }
}
