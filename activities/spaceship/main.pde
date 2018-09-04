Spaceship spaceship;
float timeSinceLastFrame = 0.0f;
PVector lastClickMouse;

void settings(){
	size(640, 640);
}

void setup(){
	spaceship = new Spaceship();
}

void draw(){
	float deltaTime = millis() - timeSinceLastFrame;
	timeSinceLastFrame = millis();
	spaceship.update(deltaTime);
	
	if(mousePressed && (lastClickMouse != null && lastClickMouse.x == mouseX && lastClickMouse.y == mouseX)){
		spaceship.multiplier += 0.01f;
	}else if(mousePressed){
		spaceship.multiplier = 0;
		lastClickMouse = new PVector(mouseX, mouseY);
		spaceship.stopPosition = lastClickMouse;
	}

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
		spaceship.fire();
	}
}
