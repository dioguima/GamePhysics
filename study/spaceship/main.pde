Nave nave;

void settings(){
  size(640, 480);
}

void setup(){
  nave = new Nave();
}

float timeSinceLastFrame = 0.0f;
void draw(){
  float deltaTime = millis() - timeSinceLastFrame;
  timeSinceLastFrame = millis();
  //nave.update(deltaTime);
  background(255);
  if(mousePressed && (mouseButton == LEFT)){
  //  nave.pos = new PVector(mouseX, mouseY);
    nave.rotateTo(mouseX, mouseY);  
}
  nave.draw();
}
