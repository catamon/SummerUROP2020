PImage prev;
int threshold = 70;

void movement(int thr){

  strokeWeight(1);
  colorMode(HSB);
  background(0);
  video.loadPixels();
  prev.loadPixels();
  for (int x = 0; x < video.width; x++){
    for (int y = 0; y < video.height; y++){
      if (y < 256){
        hue = y;
      }
      else{
        hue = y-255;
      }
      stroke(hue,255,255);
      int loc = x + y*video.width;
      color currentColor = video.pixels[loc];
      color prevColor = prev.pixels[loc];
      float d = dist(red(currentColor), green(currentColor), blue(currentColor), red(prevColor), green(prevColor), blue(prevColor));
      if (d > thr){
        point(x,y);
      }
    }
  }
}
