// Declaring variables
PImage original;
int factor;
Dither center;



void setup(){
  size(1080, 1080);
  original = loadImage("original.png");
  
  // Declare factor:
  factor = 3;
  noLoop();
}

int index(int x, int y){
  if (x == width){
    x = width - 1;
  }
  if (x == -1){
    x = 0;
  }
  if (y == height){
    y = height -1;
  }
  return int(y*original.width + x);
  }

void draw(){
  original.loadPixels();
  for (int y=0; y < original.height; y++){
    for (int x=0; x < original.width; x++){
      color pix = original.pixels[index(x,y)];
      center = new Dither(pix, factor);
      float[] error = center.findError();
      original.pixels[index(x+1, y)] = center.applyError(original.pixels[index(x+1, y)], 7/16.0, error);
      original.pixels[index(x+1, y+1)] = center.applyError(original.pixels[index(x+1, y+1)], 1/16.0, error);
      original.pixels[index(x, y+1)] = center.applyError(original.pixels[index(x, y+1)], 5/16.0, error);
      original.pixels[index(x-1, y+1)] = center.applyError(original.pixels[index(x-1, y+1)], 3/16.0, error);
    }
  }
  original.updatePixels();
  image(original, 0, 0);
  saveFrame("new.png");
  }
