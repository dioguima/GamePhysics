class Ball{
  PVector pos, vel;
  float size = 16.0f;
  
  Ball(){
    pos = new PVector(random(width), random(height));
  }
  
  void draw(){
    stroke(0);
    fill(205, 0, 0);
    ellipse(pos.x, pos.y, size, size);
  }
  
}
