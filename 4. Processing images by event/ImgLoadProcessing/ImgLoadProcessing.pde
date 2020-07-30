PImage img;
int smallPoint, largePoint;

ArrayList<PImage> images; 
void setup() {
  images = new ArrayList<PImage>();
  
  size(720, 720);
  img = loadImage("64 (3).png");
  
  smallPoint = 5;
  largePoint = 20;
  imageMode(CENTER);
  noStroke();
  background(0);
}

void draw() { 
  for(int i = 0; i<10; i++){
  float pointillize = map(mouseX, 0, width, smallPoint, largePoint);
  int x = int(random(img.width));
  int y = int(random(img.height));
  color pix = img.get(x, y);
  
  fill(pix, 100);
 // fill(random(255), random(255), random(255), 50);
  ellipse(x, y, pointillize, pointillize);
  }
}
