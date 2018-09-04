class Spaceship{
	
	PVector position;
	PVector force;
	PVector stopPosition;
	PImage image;
	float acceleration = 0;
	float angle = 0;
	float rotationDuration = 100;
	Bullet bulletAlive;
	float multiplier = 0;
	
	Spaceship(){
		position = new PVector(300, 300);
		stopPosition = position;
		image = loadImage("nave.png");
		force = new PVector(1, 0);
	}
	
	void update(float deltaTime){	
		
		position.add(force.mult(multiplier).mult(deltaTime));
		
		if(angle >= PI * 2){
			angle = 0;
		}
	}
	
	void draw(){
		pushMatrix();

		translate(position.x,position.y);
		scale(0.15, 0.15);
		rotate(angle);
		image(image,-image.width / 2, -image.height / 2);
		ellipse(position.x, position.y, 2, 2);
	
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
	
	boolean notInDestination(){
		int errorMarging = 2;
		return (position.x >= stopPosition.x + errorMarging || position.x <= stopPosition.x - errorMarging)
			&& (position.y >= stopPosition.y + errorMarging || position.y <= stopPosition.y - errorMarging);
	}
}