class Spaceship{
  
  PVector position;
  PVector force;
  PVector stopPosition;
  PImage image;
  float angle = 0;
  float launchAngle = 0;
  float rotationDuration = 100;
  
  Spaceship(){
    position = new PVector(300, 300);
    stopPosition = position;
    image = loadImage("nave.png");
    force = new PVector(0, 0);
  }
  
  void update(float deltaTime)
  {
    if(angle != launchAngle){
      angle += (deltaTime / rotationDuration) * (launchAngle - angle);
    }
    else if(NotInDestination()){
      position.add(force); //<>//
    }
    
    //Error margin
    if(launchAngle * 1.01 >= angle && launchAngle * 0.99 <= angle)
    {
      angle = launchAngle;
    }
  }
  
  void draw(){
    pushMatrix();

    translate(position.x,position.y);
    scale(0.15, 0.15);
    rotate(angle);
    image(image,-image.width / 2, -image.height / 2);
    ellipse(position.x, position.y, 2, 2);
    
    popMatrix();
  }
  
  void rotateTo(PVector newPosition){
    PVector diff = new PVector();
    diff.set(position);
    diff.sub(newPosition);
    launchAngle = diff.heading();
  }
  
  boolean NotInDestination()
  {
    return (position.x >= stopPosition.x + 5 || position.x <= stopPosition.x - 5)
      && (position.y >= stopPosition.y + 5 || position.y <= stopPosition.y - 5);
  }
  
}
