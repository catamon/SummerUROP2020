import processing.video.*;
import gab.opencv.*;


Capture video;
OpenCV opencv;
String filter = "null";
int sqWidth;
Effect effect;


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
  controlScreen();
}

void mousePressed() {
  if ((660 < mouseX) && (mouseX < 960)) {
    if ((80 < mouseY) && (mouseY < 140)) {
      effect = new Effect("BRIGHTNESS");
    }
  }
}
