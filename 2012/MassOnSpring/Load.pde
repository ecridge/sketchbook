class Load { 
  int nMasses;
  float weight;
  PVector suspensionPoint;
  
  Load(float xPos, float yPos, int nMasses_) {
    suspensionPoint = new PVector(xPos, yPos);
    nMasses =nMasses_;
    weight = nMasses * 0.010 * g;
  }
  
  void display() {
    pushMatrix();
    translate(suspensionPoint.x, suspensionPoint.y);
    strokeWeight(2);
    stroke(0);
    noFill();
    if (nMasses != 0 ) {
      ellipse(0, 0.001*PPM, 0.002*PPM, 0.002*PPM);
    }
    
    for (int i = 1; i <= nMasses; i++) {
      fill(200);
      rect(-0.01*PPM, (i+1)*0.001*PPM, 0.02*PPM, 0.001*PPM);
    }
    popMatrix();
  }
  
  void update(float yPos) {
    suspensionPoint.y = yPos;
  }
  
  void setNMasses(int newNMasses) {
    nMasses = newNMasses;
    weight = nMasses * 0.010 * g;
  }
  
  int getNMasses() {
    return nMasses;
  }
}
