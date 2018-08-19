class Spaceship{
  
  PVector position;
  PImage image;
  float angle = 0;
  
  Spaceship(){
    position = new PVector(300, 300);
    image = loadImage("nave.png");
  }
  
  void update(float deltaTime){
    angle += 0.001f * deltaTime;
  }
  
  void draw(){
    pushMatrix();

    translate(position.x,position.y);
    scale(0.25, 0.25);
    rotate(angle);
    image(image,-image.width / 2, -image.height / 2);
    ellipse(position.x, position.y, 2, 2);
    
    popMatrix();
  }
  
  void rotateTo(PVector newPosition){
    PVector diff = new PVector();
    diff.set(position);
    diff.sub(newPosition);
    angle = diff.heading();
  } //<>//
  
  void move(float velocity){
    
    position.add(new PVector(position.x + velocity, position.y + velocity));
    
  }
  
}
