class Spaceship
{
  
  PVector position;
  PVector force;
  PVector stopPosition;
  PImage image;
  float angle = 0;
  float launchAngle = 0;
  float rotationDuration = 100;
  Bullet bulletAlive;
  
  Spaceship()
  {
    position = new PVector(300, 300);
    stopPosition = position;
    image = loadImage("nave.png");
    force = new PVector(1, 0);
  }
  
  void update(float deltaTime)
  {
    if(!inLaunchAngle())
    {
      angle += (deltaTime / rotationDuration) * (launchAngle - angle);
    }
    else{
      angle = launchAngle;
    }
    
    if(notInDestination() && launchAngle == angle)
    {
        position.add(force);
    }
    
    if(angle >= PI * 2)
    {
      angle = 0;
    }
  }
  
  void draw()
  {
    pushMatrix();

    text("X verification: " + (position.x >= stopPosition.x + 5 || position.x <= stopPosition.x - 5) + 
      " | Y verification: " + (position.y >= stopPosition.y + 5 || position.y <= stopPosition.y - 5),50,50);
      
    text("Mouse click       => X: " + stopPosition.x + " Y: " + stopPosition.y, 50, 100);
    text("Spaceship pos     => X: " + position.x + " Y: " + position.y, 50, 120);
    text("Spaceship angle   => " + angle, 50, 140);
    text("Spaceship l angle => " + launchAngle, 50, 160);
    text("Spaceship force   => X :" + force.x + " Y: " + force.y, 50, 180);
    text("Spaceship inLAngle => " + inLaunchAngle(), 50, 200);
    
    translate(position.x,position.y);
    scale(0.15, 0.15);
    rotate(angle);
    image(image,-image.width / 2, -image.height / 2);
    ellipse(position.x, position.y, 2, 2);
    
    popMatrix();

    if(bulletAlive != null){
      bulletAlive.update();
      bulletAlive.draw();
    }
    
  
  }
  
  void rotateTo(PVector newPosition)
  {
    PVector diff = new PVector();
    diff.set(position);
    diff.sub(newPosition); //<>//
    launchAngle = diff.heading();
  }
  
  void fire(){
    this.bulletAlive = new Bullet(position, force);
  }
  
  boolean notInDestination()
  {
    int errorMarging = 2;
    return (position.x >= stopPosition.x + errorMarging || position.x <= stopPosition.x - errorMarging)
      && (position.y >= stopPosition.y + errorMarging || position.y <= stopPosition.y - errorMarging);
  }
  
  boolean inLaunchAngle()
  {
    float absLaunchAngle = abs(launchAngle);
    float absAngle = abs(angle);
    return angle != launchAngle && absLaunchAngle * 1.02 >= angle && absLaunchAngle * 0.98 <= absAngle;
  }
  
}
