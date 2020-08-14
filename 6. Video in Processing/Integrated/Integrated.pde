import processing.video.*;

Capture video;

void captureEvent (Capture video){
  video.read();
}

void setup(){
  size(640, 480);
  video = new Capture(this, 640, 480);
  video.start();
  
}
