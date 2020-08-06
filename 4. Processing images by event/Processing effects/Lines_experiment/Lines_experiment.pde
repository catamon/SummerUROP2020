// Given an image edited with edges, I want to experiment with creting lines

float bigLine = 10;
float smallLine = 1;
PImage original;

void setup(){
  size(1080, 1080);
  original = loadImage("original.png");
  background(0);
  noLoop();
}

void draw(){
  original.loadPixels();
  for (int x=0; x< original.width; x++){
    for (int y = 0; y < original.height; y++){
       int i = y * original.width + x;
       color pixel = original.pixels[i];
       if (pixel != color(0,0,0)){
         pushMatrix();
         translate(x,y);
         rotate(random(360));
         //rotate(45);
         //float size = 7;
         float size = random(smallLine, bigLine);
         stroke(pixel);
         line(0,0,0,size);
         line(0,0,0,-size);
         popMatrix();
       }
  }
  }
  save("black_background_45_size7.png");
}
