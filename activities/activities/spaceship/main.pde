Spaceship spaceship;
Scenario scenario;
float timeSinceLastFrame = 0.0f;
PVector lastClickMouse;

void settings(){
	size(800, 800);
}

void setup(){
	spaceship = new Spaceship();
  scenario = new Scenario(this);
  smooth();
  noStroke();
}

void draw(){
  background(200, 196, 183);	
  
  float deltaTime = millis() - timeSinceLastFrame;
	timeSinceLastFrame = millis();
	
	if(mousePressed && mouseButton == LEFT){
    
    PVector mouseClick = new PVector(mouseX, mouseY);
    spaceship.addForce(mouseClick, deltaTime);

	}else if(mousePressed && mouseButton == RIGHT){
    
    PVector mouseClick = new PVector(mouseX, mouseY);
    spaceship.fire(mouseClick);
  
  }
  
  spaceship.update(deltaTime);
  scenario.drawFlag();
	spaceship.draw();
  scenario.drawFloor();
}
