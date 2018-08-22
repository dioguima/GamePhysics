Spaceship spaceship;

void settings(){
  size(640, 640);
}

void setup(){
  spaceship = new Spaceship();
}

float timeSinceLastFrame = 0.0f;
void draw(){
  float deltaTime = millis() - timeSinceLastFrame;
  timeSinceLastFrame = millis();
  spaceship.update(deltaTime);
  //background(255);
  //if(mousePressed && (mouseButton == LEFT)){
  //  nave.pos = new PVector(mouseX, mouseY);
    
  //}
  
  background(255);
  fill(0);
  spaceship.draw();
  
  /*
  if(mousePressed){
     text("X: " + mouseX + " / Y: " + mouseY + " | angle: " + spaceship.angle, 50, 50);  
  }
  */
  
}

void mouseClicked(){
  
  PVector mouseClick = new PVector(mouseX, mouseY);
  PVector diff = new PVector();
  diff.set(spaceship.position);
  diff.sub(mouseClick);
  
  spaceship.stopPosition = mouseClick;
  spaceship.force = diff.mult(-0.01f);
  spaceship.rotateTo(mouseClick);
  background(255);
  fill(0);
  
  
}
