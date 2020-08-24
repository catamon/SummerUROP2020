import processing.video.*;
import gab.opencv.*;


Capture video;
OpenCV opencv;
String filter = "NULL";
int sqWidth;
Effect none;
Effect q;


void captureEvent (Capture video) {
  prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  video.read();
}

void setup() {
  size(980, 480);
  video = new Capture(this, 640, 480);
  video.start();
  prev = createImage(640, 480, RGB);
  opencv = new OpenCV(this, video);
  sqWidth = width -video.width;
}

void draw() {
  none = new Effect(filter);
  controlScreen();
  //getCenter(filter);
  
}

void mousePressed() {
  if ((660 < mouseX) && (mouseX < 960)) {
    if ((80 < mouseY) && (mouseY < 140)) {
      filter = "BRIGHTNESS";
    }
    if ((160 < mouseY) && (mouseY < 220)) {
      filter = "CIRCLES";
    }
    if ((240 < mouseY) && (mouseY < 300)) {
      filter = "CONTOURS";
    }
    if ((320 < mouseY) && (mouseY < 380)) {
      filter = "MOVEMENT";
    }
    if ((400 < mouseY) && (mouseY < 460)) {
      filter = "QUANT";
    }
  
  }
}
