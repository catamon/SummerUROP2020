import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

void setup() {
  size(640, 480);
  video = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
}

void draw() {
  scale(1);
  opencv.loadImage(video);

  image(video, 0, 0 );
  video.loadPixels();

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect(); //detects faces
// This turns the rectangle that the faces are in to blck and white
  for (int i = 0; i < faces.length; i++) {
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    for (int m = faces[i].x; m <faces[i].width+faces[i].x; m++){
      for (int n = faces[i].y; n < faces[i].height+faces[i].y; n++){
        color pix = video.pixels[n*width+m];
        color newPix = color((red(pix)+blue(pix)+green(pix))/3);
        video.pixels[n*width+m] = newPix;
      }
    }
    video.updatePixels();
        
  }
}

void captureEvent(Capture c) {
  c.read();
}
