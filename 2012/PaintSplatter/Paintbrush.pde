class Paintbrush {
  Random generator;
  
  Paintbrush(Random g) {
    generator = g;
  }
  
  void splatter(int x, int y) {
    int hue = int( (millis()/50.0)%360.0 );
    noStroke();
    
    float s = (float) generator.nextGaussian()*300.0 + 1000.0;
    
    for (int i = 0; i < s; i++) {
      float p, q, r;
      
      p = (float) generator.nextGaussian()*(s/40.0) + x;
      q = (float) generator.nextGaussian()*(s/40.0) + y;
      r = (float) generator.nextGaussian()*5.0 + 5.0;
      
      color c = color(hue+r/5.0, 360, 180, 300);
      fill(c);
      
      ellipse(p, q, r, r);
    }
  }
}
