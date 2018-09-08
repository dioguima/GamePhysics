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
    PVector diff = new PVector();
    diff.set(mouseClick);
    diff.sub(spaceship.position);
    diff.normalize();
    diff.mult(spaceship.propForce);
    diff.mult(deltaTime/1000);
    
    spaceship.rotateTo(mouseClick);
    spaceship.force.add(diff);
    
	}else if(mousePressed && mouseButton == RIGHT){
    
    spaceship.fire();
  
  }
  
  spaceship.update(deltaTime);
  scenario.drawFlag();
	spaceship.draw();
  scenario.drawFloor();
}

/*
void mouseClicked(){

  if(mouseButton == LEFT){
		PVector mouseClick = new PVector(mouseX, mouseY);
		PVector diff = new PVector();
		diff.set(spaceship.position);
		diff.sub(mouseClick);

		spaceship.stopPosition = mouseClick;
		spaceship.force = diff.mult(-0.01f);
		spaceship.rotateTo(mouseClick);
		
	}else if(mouseButton == RIGHT){
		spaceship.fire();
	}
}
*/
