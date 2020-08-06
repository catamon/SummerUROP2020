PImage original;

void setup(){
 size(912, 912);
 background(255);
 original = loadImage("original.png");
 colorMode(HSB);
}



void draw(){
  int x = int(random(width));
  int y = int(random(height));
  color pix = original.pixels[x + width*y];
  if (pix != color(0)){
    original.loadPixels();
    int hu = 0;
    findBlackNeighbours(x,y,hu);
  }
  
  
}

int findPixel(int x, int y){
  if (x == width){
    return -1;
  }
  if (x == -1){
    return -1;
  }
  if (y == height){
    return -1;
  }
  if (y == -1){
    return -1;
  }
  return int(y*original.width + x);
  } 

void findBlackNeighbours(int x, int y, int hu){
 if (hu > 255){
   hu = 0;
 }
 original.loadPixels();
 original.pixels[x+y*width] = color(hu, 255, 255);
 int up = findPixel(x, y-1);
 if (up != -1 && original.pixels[up] == color(0)){ 
   original.pixels[up] = color(hu+1, 255,255);
   findBlackNeighbours(x,y-1, hu+1);
 }
 int down = findPixel(x, y+1);
 if (down != -1 && original.pixels[down] == color(0)){ 
   original.pixels[down] = color(hu+1, 255,255);
   findBlackNeighbours(x,y+1, hu+1);
 }
 int right = findPixel(x+1, y);
 if (right != -1 && original.pixels[right] == color(0)){ 
   original.pixels[right] = color(hu+1, 255,255);
   findBlackNeighbours(x+1,y, hu+1);
 }
 int left = findPixel(x-1, y);
 if (left != -1 && original.pixels[left] == color(0)){ 
   original.pixels[left] = color(hu+1, 255,255);
   findBlackNeighbours(x-1,y, hu+1);
 }
 updatePixels();
}
