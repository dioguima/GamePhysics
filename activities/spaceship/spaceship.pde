class Spaceship{
	
	PVector position;
	PVector force;
	PVector stopPosition;
	PImage image;
	float angle = 0;
	Bullet bulletAlive;

  float gForce = 10; 
  float windForce = 3;
  float propForce = 15;	

	Spaceship(){
		position = new PVector(300, 300);
		stopPosition = position;
		image = loadImage("nave.png");
		force = new PVector(0, 0);
	}
	
	void update(float deltaTime){	
		
    if(position.x < width){
      PVector windForceVector = new PVector();
      windForceVector.x = windForce * (deltaTime/1000);
      windForceVector.y = 0;
      force.add(windForceVector);
    }
    
    if((force.x > 0 && position.x > width) || (force.x < 0 && position.x < 0)){
      force.x = 0;
    }
  
    if(position.y < height - scenario.floorHeight){
      PVector gForceVector = new PVector();
      gForceVector.x = 0;
      gForceVector.y = gForce * (deltaTime/1000);  
      force.add(gForceVector);    
    }
    
    if((force.y > 0 && position.y > height - scenario.floorHeight) || (force.y < 0 && position.y < 0)){
      force.y = 0;
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
	
	void fire(){
		this.bulletAlive = new Bullet(position, force);
	}
}
