Ball b = new Ball();

void settings(){
  size(640, 480);
}

void setup(){
  
  
}

void draw(){
  triangle(18, 18, 18,360,81,360);
  rect(81,63,63,63);
  fill(0);
  quad(189, 128, 216, 128, 326, 360, 144, 360);
  fill(128);
  ellipse(81, 81, 72, 72);
  arc(479, 300, 280, 280, PI, TWO_PI);
  b.draw();
}
