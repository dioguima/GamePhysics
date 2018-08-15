class Nave{
  
  PVector pos;
  PImage img;
  float angle = 0;
  
  Nave(){
    pos = new PVector(300, 300);
    img = loadImage("nave.png");
  }
  
  void update(float deltaTime){
    angle += 0.001f * deltaTime;
  }
  
  void draw(){
    pushMatrix();

    translate(pos.x, pos.y);
    scale(0.25, 0.25);
    rotate(angle);
    image(img,-img.width / 2, -img.height / 2);
    
    popMatrix();
  }
  
  void move(int xValue, int yValue){
    
    
      
    
    
  }

  void rotateTo(int xValue, int yValue){
    rotate(0);
    PVector click = new PVector(xValue, yValue);
    angle = PVector.angleBetween(pos, click);
    if(pos.x < xValue && pos.y > yValue){
      angle += -0.5;
    }
    else if(pos.x > xValue && pos.y > yValue){
      angle += -1;
    }
    else if (pos.x > xValue && pos.y < yValue){
      angle += -1.5;
    }
  } //<>//

}
