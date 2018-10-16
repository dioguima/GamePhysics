public class Moon{

  PVector position;
  PImage sprite;
  
  public Moon(PVector position){
    this.position = position;
    this.sprite = loadImage("moon.png");
  }
  
  public void draw(){
    pushMatrix();
    
    translate(position.x,position.y);
    scale(0.4,0.4);
    image(sprite,-sprite.width / 2, -sprite.height / 2);
    scale(2.5,2.5);
    
    popMatrix();
  }

}
