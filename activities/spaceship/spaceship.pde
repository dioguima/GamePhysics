class Spaceship{
	
	PVector position;
	PVector force;
	PVector stopPosition;
	PImage image;
	Bullet bulletAlive;
  
  float angle = 0;
  float gAcceleration = 10;
  float propellantForce = 20000;
  float mass = 1000;

	Spaceship(){
		position = new PVector(300, 300);
		stopPosition = position;
		image = loadImage("nave.png");
		force = new PVector(0, 0);
	}
	
	void update(float deltaTime){	
	
    if(position.y < height - scenario.floorHeight){
      PVector gForceVector = new PVector();
      gForceVector.x = 0;
      gForceVector.y = gAcceleration * (deltaTime/1000);  
      force.add(gForceVector);    
    }
    
    //if((force.y > 0 && position.y > height - scenario.floorHeight) || (force.y < 0 && position.y < 0)){
    if((force.y > 0 && position.y > height - scenario.floorHeight)){
      force.y *= -1;
    }
  
    position.add(force);
		
		if(angle >= PI * 2){
			angle = 0;
		}
	}
	
	void draw(){
		pushMatrix();

    text("Force x: " + force.x + " | Force y: " + force.y, 50, 50);

		translate(position.x,position.y);
		scale(0.15, 0.15);
		rotate(angle);
		image(image,-image.width / 2, -image.height / 2);
	  
		popMatrix();

		if(bulletAlive != null){
			bulletAlive.update();
			bulletAlive.draw();
		}
	}
	
	void rotateTo(PVector newPosition){
		PVector diff = new PVector();
		diff.set(position);
		diff.sub(newPosition);
		angle = diff.heading();
	}
	
	void fire(PVector mouseClick){
		this.bulletAlive = new Bullet(position, mouseClick.normalize());
	}

  void addForce(PVector mouseClick, float deltaTime){
    PVector diff = new PVector();
    diff.set(mouseClick);
    diff.sub(spaceship.position);
    diff.normalize();
    diff.mult(propellantForce / mass);
    diff.mult(deltaTime/1000);
    
    rotateTo(mouseClick);
    force.add(diff);
  }
}
