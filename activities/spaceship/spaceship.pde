class Spaceship{
	
	PVector position;
	PVector velocity;
	PVector stopPosition;
	PImage image;
	Bullet bulletAlive;
  
  float angle = 0;
  float gAcceleration = 1;
  float propellantForce = 20000;
  float mass = 1000;
  float airDensity = 0.000001;

	Spaceship(){
		position = new PVector(300, 700);
		stopPosition = position;
		image = loadImage("nave.png");
		velocity = new PVector(0, 0);
	}
	
	void update(float deltaTime){	
	
    updateVelocity(deltaTime);
  
    position.add(velocity);
		
		if(angle >= PI * 2){
			angle = 0;
		}
	}
	
	void draw(){
		pushMatrix();

      float contactArea = abs(cos(abs(angle)) * image.width) + abs(cos(abs(angle) + 1.5708) * image.height);
      float airResistanceForce = -0.5 * airDensity * pow(velocity.y, 2) * contactArea;
      text(airResistanceForce, 50, 50);

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
	
  void updateVelocity(float deltaTime){
  
    //Gravity
    if(position.y < height - scenario.floorHeight){
      PVector gForceVector = new PVector();
      gForceVector.x = 0;
      gForceVector.y = gAcceleration * (deltaTime/1000);  
      velocity.add(gForceVector);    
    }
    
    //Hit on floor
    if((velocity.y > 0 && position.y > height - scenario.floorHeight)){
      velocity.y *= -1;
    }
  
    //Air resistence
    if(velocity.y > 0){
      //float contactArea = cos(abs(angle)) * image.width;
      float contactArea = abs(cos(abs(angle)) * image.width) + abs(cos(abs(angle) + 1.5708) * image.height);
      float airResistanceForce = -0.5 * airDensity * pow(velocity.y, 2) * contactArea;
      
      velocity.y += airResistanceForce * deltaTime;
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
    velocity.add(diff);
  }
}
