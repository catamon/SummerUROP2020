int h = 0;
float positionX = 19;
float positionY = 10;

void setup(){
  size(600,600);
  colorMode(HSB);
  background(0);
  
}


void draw(){
  //background(0);
  textSize(15);
  fill(h,255,255);
  noStroke();
  if (mousePressed == true){
    ellipse(mouseX, mouseY, 10, 10);
    h += 1;
  }
  if (keyPressed == true){
    fill(h, 0,255);
    text(key,positionX,positionY);
    delay(200);
    positionX += 20;
  }
  if (h>255) {
    h = 0;
  }
}

void mousePressed(){
  positionX = mouseX;
  positionY = mouseY;
  saveFrame("interactive_drawing_2.png");
}
