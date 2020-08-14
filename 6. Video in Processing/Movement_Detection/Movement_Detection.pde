
import processing.video.*;

Capture video;
PImage prev;
int threshold = 70;
int hue;

void captureEvent(Capture video) {
  prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  video.read();
}

void setup() {
  size(640, 480);
  video = new Capture(this, 640, 480);
  prev = createImage(640, 480, RGB);
  video.start();
  strokeWeight(1);
  colorMode(HSB);
}

void draw() {
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
      if (d > threshold){
        point(x,y);
      }
    }
  }
}
