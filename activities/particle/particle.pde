PVector gAcceleration = new PVector(0, 10);

public class Particle{

  PVector position, velocity;
  float radius;
  Particle child;
  float timeLeft;
  
  public Particle(PVector position, PVector velocity, float radius){
    this.position = position;
    this.velocity = velocity;
    this.radius = radius;
    this.timeLeft = 3000;
  }

  public void update(float deltaTime){
    
    timeLeft -= deltaTime;

    if(child != null){
      child.update(deltaTime);
    }
    else if(timeLeft > 0){
      PVector childPosition = new PVector(this.position.x, this.position.y);
      PVector newVelocity = PVector.mult(this.velocity, 0.8);
      child = new Particle(childPosition, newVelocity, this.radius); //<>//
    }
    
    velocity.mult(.99);
    
    PVector gVelocity = PVector.mult(gAcceleration, deltaTime / 1000);
    position.add(gVelocity);
    
    position.add(PVector.mult(velocity ,deltaTime / 1000)); //<>//
    
  }
  
  public void draw(){
    
    //if(this.timeLeft > 0){
      
      pushMatrix();
      
      fill(255);
      translate(position.x, position.y);
      ellipse(-radius / 2, -radius / 2, radius, radius);
      
      popMatrix();
    //}
    
    if(child != null){
      child.draw();
    }  
  }

  public Particle getChild(){
  
    if(child == null){
      PVector newPosition = PVector.add(this.position, this.velocity);
      child = new Particle(newPosition, this.velocity, this.radius);
    }
    return child;
  }

}
