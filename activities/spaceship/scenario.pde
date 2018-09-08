import gifAnimation.*;

class Scenario{

  PImage flag;
  float flagScale = 0.3f;
  Gif animation;
  float floorHeight = 10f;
  
  Scenario(PApplet pApplet){
     animation = new Gif(pApplet, "flag.gif");
     animation.play();
  }
  
  void drawFlag(){
  
    pushMatrix();

    scale(flagScale,flagScale);
    image(animation, 50, ((height) * (1 / flagScale)) - floorHeight - animation.height); //<>//
    
    popMatrix();
  }
  
  void drawFloor(){
  
    pushMatrix();
    
    fill(0, 160, 40);
    quad(0, width - floorHeight, height, width - floorHeight, width, height, 0, height);
    
    popMatrix();
  }
  
}
