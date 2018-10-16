class Bullet{

  PVector position;
  int size = 10;
  PVector force;
  
  Bullet(PVector position, PVector force){
    this.position = new PVector(position.x, position.y);
    this.force = new PVector(force.x * 10, force.y * 10);
  }
  
  void update(){
    this.position.add(this.force);
  }
  
  void draw(){
  
    pushMatrix();
    
    stroke(0);
    fill(200, 0, 0);
    ellipse(position.x, position.y, size, size);
    
    popMatrix();
  }

}
