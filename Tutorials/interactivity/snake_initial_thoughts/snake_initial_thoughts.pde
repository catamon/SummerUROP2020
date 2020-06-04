int positionX = 0;
int positionY = 0;

void setup(){
  size(600,600);
  background(0);
}

void draw(){
  fill(0,255,0);
  rect(positionX,positionY, 10,10);
  if ((keyPressed == true) && (key == CODED)) {
    if (keyCode == UP){
      positionY -= 1;
      if (positionY < 0) {
        exit();
      }
    }
    if (keyCode == DOWN){
      positionY += 1;
      if (positionY+10 > height) {
        exit();
      }
    }
    if (keyCode == LEFT){
      positionX -= 1;
      if (positionX < 0) {
        exit();
      }
    }
    if (keyCode == RIGHT){
      positionX += 1;
      if (positionX+10 > width) {
        exit();
      }
    }
  }
}
