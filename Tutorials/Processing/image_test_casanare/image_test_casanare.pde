PImage casanare;
PImage cabo;

void setup(){
  size(1000,666);
  casanare = loadImage("casanare_atardecer.JPG");
  cabo = loadImage("cabo.JPG");
  noLoop();
}

void draw(){
  image(casanare, 0, 0, 1000, 666);
  tint(100,100,120,128);
  image(cabo, -200,100, 1000,666);
}

void mousePressed(){
  saveFrame("editedimage.jpg");
}
