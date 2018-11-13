public class Firework{
 
  PVector position;
  Particle[] children;
  float particleVelocity;
  float particleRadius;
  
  public Firework(PVector position){
    this.particleVelocity = 100;
    this.particleRadius = 5;
    this.position = position;
    this.children = new Particle[16];
    this.children[0] = new Particle(new PVector(position.x, position.y), new PVector(0, -this.particleVelocity), this.particleRadius);
    this.children[1] = new Particle(new PVector(position.x, position.y), new PVector(this.particleVelocity, -this.particleVelocity), this.particleRadius);
    this.children[2] = new Particle(new PVector(position.x, position.y), new PVector(this.particleVelocity, 0), this.particleRadius);
    this.children[3] = new Particle(new PVector(position.x, position.y), new PVector(this.particleVelocity, this.particleVelocity), this.particleRadius);
    this.children[4] = new Particle(new PVector(position.x, position.y), new PVector(0, this.particleVelocity), this.particleRadius);
    this.children[5] = new Particle(new PVector(position.x, position.y), new PVector(-this.particleVelocity, this.particleVelocity), this.particleRadius);
    this.children[6] = new Particle(new PVector(position.x, position.y), new PVector(-this.particleVelocity, 0), this.particleRadius);
    this.children[7] = new Particle(new PVector(position.x, position.y), new PVector(-this.particleVelocity, -this.particleVelocity), this.particleRadius);

    this.children[0] = new Particle(new PVector(position.x, position.y), new PVector(0, -this.particleVelocity), this.particleRadius);
    this.children[1] = new Particle(new PVector(position.x, position.y), new PVector(this.particleVelocity, -this.particleVelocity), this.particleRadius);
    this.children[2] = new Particle(new PVector(position.x, position.y), new PVector(this.particleVelocity, 0), this.particleRadius);
    this.children[3] = new Particle(new PVector(position.x, position.y), new PVector(this.particleVelocity, this.particleVelocity), this.particleRadius);
    this.children[4] = new Particle(new PVector(position.x, position.y), new PVector(0, this.particleVelocity), this.particleRadius);
    this.children[5] = new Particle(new PVector(position.x, position.y), new PVector(-this.particleVelocity, this.particleVelocity), this.particleRadius);
    this.children[6] = new Particle(new PVector(position.x, position.y), new PVector(-this.particleVelocity, 0), this.particleRadius);
    this.children[7] = new Particle(new PVector(position.x, position.y), new PVector(-this.particleVelocity, -this.particleVelocity), this.particleRadius);

}
  
  public void update(float deltaTime){
    
    for(int i = 0; i < 8; i++){
      this.children[i].update(deltaTime);
    }
    
  }
  
  public void draw(){
  
    for(int i = 0; i < 8; i++){
      this.children[i].draw();
    }
  
  }
  
  
}
