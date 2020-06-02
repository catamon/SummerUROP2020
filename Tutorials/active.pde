import processing.pdf.*;



// Active sketch

// PImage image = loadImage("Image17.png");

int blue = 0;
int g = 255;
int red = 0;

void setup() {
  size(400, 400);
  background(255);
  stroke(red, g, blue);
  
}

void draw() {
  if (blue < 255) {
    blue = blue +1;
    g = g-1;
  }
  else {
    red = red +1;
  }
  stroke(red, g, blue);
  line(width/2, height/2, mouseX, mouseY);
}

void mousePressed() {
  saveFrame("output.png");
  background(255);
  blue = 0;
  g = 255;
  red = 0;
}
