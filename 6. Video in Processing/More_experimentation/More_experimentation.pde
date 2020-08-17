import gab.opencv.*;
import processing.video.*;

OpenCV opencv;
Capture video;
PImage src, canny, scharr, sobel;
ArrayList<Contour> contours;
int hue = 0;

void captureEvent(Capture video){
  video.read();
}

void setup() {
  video = new Capture(this, 640, 480);
  size(640, 480);
  video.start();
  opencv = new OpenCV(this, video);
  colorMode(HSB);
}

void draw(){
  background(0);
  opencv.loadImage(video);
  
  opencv.gray();
  opencv.threshold(127);
  //image(opencv.getOutput(),0,0);
  contours = opencv.findContours();
    
noFill();
  strokeWeight(2);
  
  for (Contour contour : contours) {
    stroke(255);
    contour.draw();
    
    
    beginShape();
    for (PVector point : contour.getPolygonApproximation().getPoints()) {
        if (hue == 255){
    hue = 0;
  }
      stroke(hue, 255, 255);
      vertex(point.x, point.y);
      hue++;
    }
    endShape();
  }
  
}
