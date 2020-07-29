PImage original;
PImage transformed;
int r_max = 10;
int loop = 0;

void setup(){
  original = loadImage("266.png");
  size(1080, 804);
  background(0);
  noStroke();
}

void draw(){
  int x = int(random(width));
  int y = int(random(height));
  color pix = original.get(x, y);
  fill(pix);
  float rad = random(r_max);
  ellipse(x,y,rad, rad);
  if (loop%500 == 0){
    saveFrame("/niñas2/niña_######.jpg");
  }
  loop += 1;
}
