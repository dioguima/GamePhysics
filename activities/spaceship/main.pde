Spaceship spaceship;

void settings()
{
  size(640, 640);
}

void setup()
{
  spaceship = new Spaceship();
}

float timeSinceLastFrame = 0.0f;
void draw(){
  float deltaTime = millis() - timeSinceLastFrame;
  timeSinceLastFrame = millis();
  spaceship.update(deltaTime);
  background(255);
  fill(0);
  spaceship.draw();
}

void mouseClicked(){
  
  if(mouseButton == LEFT){
    PVector mouseClick = new PVector(mouseX, mouseY);
    PVector diff = new PVector();
    diff.set(spaceship.position);
    diff.sub(mouseClick);
  
    spaceship.stopPosition = mouseClick;
    spaceship.force = diff.mult(-0.01f);
    spaceship.rotateTo(mouseClick);
    background(255);
    fill(0);
  }else if(mouseButton == RIGHT){
    spaceship.fire(); //<>//
  }
  
  
}

//void m
