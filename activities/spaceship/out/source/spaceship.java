import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class spaceship extends PApplet {



class Spaceship
{
  
  PVector position;
  PVector force;
  PVector stopPosition;
  PImage image;
  float angle = 0;
  float launchAngle = 0;
  float rotationDuration = 100;
  Bullet bulletAlive;
  
  Spaceship()
  {
    position = new PVector(300, 300);
    stopPosition = position;
    image = loadImage("nave.png");
    force = new PVector(1, 0);
  }
  
  public void update(float deltaTime)
  {
    if(!inLaunchAngle())
    {
      angle += (deltaTime / rotationDuration) * (launchAngle - angle);
    }
    else{
      angle = launchAngle;
    }
    
    if(notInDestination() && launchAngle == angle)
    {
      float x = (position.x - stopPosition.x) / 500 * deltaTime * -1;
      float y = (position.y - stopPosition.y) / 500 * deltaTime * -1;
      PVector aux = new PVector(x, y);
      position.add(aux);
          //position.add(force);
    }
    
    if(angle >= PI * 2)
    {
      angle = 0;
    }
  }
  
  public void draw()
  {
    pushMatrix();

    translate(position.x,position.y);
    scale(0.15f, 0.15f);
    rotate(angle);
    image(image,-image.width / 2, -image.height / 2);
    ellipse(position.x, position.y, 2, 2);
    
    popMatrix();

    if(bulletAlive != null){
      bulletAlive.update();
      bulletAlive.draw();
    }
    
  
  }
  
  public void rotateTo(PVector newPosition)
  {
    PVector diff = new PVector();
    diff.set(position);
    diff.sub(newPosition); //<>//
    launchAngle = diff.heading();
  }
  
  public void fire(){
    this.bulletAlive = new Bullet(position, force);
  }
  
  public boolean notInDestination()
  {
    int errorMarging = 2;
    return (position.x >= stopPosition.x + errorMarging || position.x <= stopPosition.x - errorMarging)
      && (position.y >= stopPosition.y + errorMarging || position.y <= stopPosition.y - errorMarging);
  }
  
  public boolean inLaunchAngle()
  {
    float absLaunchAngle = abs(launchAngle);
    float absAngle = abs(angle);
    return angle != launchAngle && absLaunchAngle * 1.02f >= angle && absLaunchAngle * 0.98f <= absAngle;
  }
  
}
class Bullet{

  PVector position;
  int size = 10;
  PVector force;
  
  Bullet(PVector position, PVector force){
    this.position = new PVector(position.x, position.y);
    this.force = new PVector(force.x * 10, force.y * 10);
  }
  
  public void update(){
    this.position.add(this.force);
  }
  
  public void draw(){
  
    pushMatrix();
    
    stroke(0);
    fill(200, 0, 0);
    ellipse(position.x, position.y, size, size);
    
    popMatrix();
  }

}
Spaceship spaceship;

public void settings()
{
  size(640, 640);
}

public void setup()
{
  spaceship = new Spaceship();
}

float timeSinceLastFrame = 0.0f;
public void draw(){
  float deltaTime = millis() - timeSinceLastFrame;
  timeSinceLastFrame = millis();
  spaceship.update(deltaTime);
  background(255);
  fill(0);
  spaceship.draw();
}

public void mouseClicked(){
  
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
    spaceship.fire(); //<>//
  }
  
  
}

//void m
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "spaceship" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
