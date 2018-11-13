Firework firework;

void settings(){
  size(1000,500);
}

void setup(){
  smooth();
  noStroke();
}

float timeSinceLastFrame = 0;
void draw(){
  
  float deltaTime = millis() - timeSinceLastFrame;
  timeSinceLastFrame = millis();
  
  background(68);
  
  if(firework != null){
    firework.update(deltaTime);
    firework.draw();
  }
}

void mouseClicked(){
  
  PVector position = new PVector(mouseX, mouseY);
  firework = new Firework(position);

}
