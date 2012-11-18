class Spring {
  PVector fixedPoint, freePoint;
  float l, k, radius, stretchedLength, extension;
  
  Spring(int xPos, int yPos, float naturalLength, float springConstant) {
    fixedPoint = new PVector(xPos, yPos);
    l = naturalLength;
    k = springConstant;
    
    extension = 0;
    radius = 0.004;
    
    stretchedLength = l;
    freePoint = new PVector(fixedPoint.x, fixedPoint.y + (l + 4*radius)*PPM);
  }
  
  void update(float load) {
    float resultantForce;
    extension = load / k;
    
    stretchedLength = l + extension;
    freePoint.y = fixedPoint.y + (stretchedLength + 4*radius)*PPM;
  }
  
  void display() {
    pushMatrix();
    translate(fixedPoint.x, fixedPoint.y);
    strokeWeight(2);
    stroke(0);
    noFill();
    rect(-radius*PPM, 2*radius*PPM, 2*radius*PPM, stretchedLength*PPM);
    
    noFill();
    ellipse(0, radius*PPM, 2*radius*PPM, 2*radius*PPM);
    ellipse(0, (stretchedLength + 3*radius)*PPM, 2*radius*PPM, 2*radius*PPM);
    
    for (int i = 0; i < 30; i++) {
      line(-radius*PPM, (i+0.5)*(stretchedLength/30)*PPM + 2*radius*PPM, radius*PPM, i*(stretchedLength/30)*PPM + 2*radius*PPM);
    }
    popMatrix();
  }
}
