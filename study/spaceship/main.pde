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
  //nave.update(deltaTime);
  //background(255);
  if(mousePressed && (mouseButton == LEFT)){
  //  nave.pos = new PVector(mouseX, mouseY);
    background(255);
    fill(0);
  }
  spaceship.draw();
  
  /*
  if(mousePressed){
     text("X: " + mouseX + " / Y: " + mouseY + " | angle: " + spaceship.angle, 50, 50);  
  }
  */
  
}

void mouseClicked(){
  
  spaceship.rotateTo(new PVector(mouseX, mouseY));
  background(255);
  fill(0);
  //spaceship.move(0.1f);
  
}
