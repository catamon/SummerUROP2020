import gab.opencv.*;
import processing.video.*;
//Effect goes to min brighness to full brightness and then back.
Capture video;
OpenCV opencv;
int n = -255;
int i = -1;

void captureEvent(Capture video){
  video.read();
}

void setup(){
  video = new Capture(this, 640,480);
  size(640, 480);
  opencv = new OpenCV(this, video);
  video.start();
}

void draw(){
  if ((n==255)||(n==-255)){
    i= i*-1;
  }
  opencv.loadImage(video);
  opencv.brightness((int)n);
  image(opencv.getOutput(),0,0);
  
  n = n+i;
}
