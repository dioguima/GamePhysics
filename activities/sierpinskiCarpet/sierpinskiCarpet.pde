static int maxGens = 0;

void settings(){
  size(800,800);
}

void setup(){
  noLoop();
  smooth();
  
  maxGens = 0;
}

void draw(){
  background(255);
  fill(0);
 
  text("Generations: " + maxGens, 50, 50);
  drawSquare(width/2, width/2, width / 3, 0);
}

void drawSquare(int xCenter, int yCenter, int size, int currentGen){
  
  if(currentGen >= maxGens)
  {
    return; //<>//
  }
  
  int initialX = xCenter - size / 2; //<>//
  int initialY = yCenter - size / 2;
  
  fill(random(0, 255), random(0, 255), random(0, 255));
  quad(initialX, initialY, initialX + size, initialY, initialX + size, initialY + size, initialX, initialY + size);
  
  int childSize = size / 3;
  int nextGen = currentGen + 1;
  
  drawSquare(xCenter + size, yCenter, childSize, nextGen);
  drawSquare(xCenter + size, yCenter + size, childSize, nextGen);
  drawSquare(xCenter, yCenter + size, childSize, nextGen);
  
  drawSquare(xCenter - size, yCenter + size, childSize, nextGen);
  drawSquare(xCenter - size, yCenter, childSize, nextGen);
  drawSquare(xCenter - size, yCenter - size, childSize, nextGen);
  
  drawSquare(xCenter, yCenter - size, childSize, nextGen);
  drawSquare(xCenter + size, yCenter - size, childSize, nextGen);
}

void mouseClicked(){
  
  maxGens++;
  redraw();

}
