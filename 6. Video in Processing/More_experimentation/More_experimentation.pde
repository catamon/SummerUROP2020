import gab.opencv.*;
impor processing.video.*;

OpenCV opencv;
Capture video;
PImage src, canny, scharr, sobel;

void captureEvent(Capture video){
  video.read();
}

void setup(){
  video = new Capture(this, 640, 480);
  size(64', 480);
  video.start();
  opencv = new OpenCV(this, video);
}

void draw(){
  opencv.findCannyEdges(20,75);
  canny = opencv.getSnapshot();
  
  opencv.loadImage(video);
  opencv.findScharrEdges(OpenCV.HORIZONTAL);
  scharr = opencv.getSnapshot();
  
  opencv.loadImage(video);
  opencv.findSobelEdges(1,0);
  sobel = opencv.getSnapshot();
  pushMatrix();
  scale(0.5);
  image(video, 0, 0);
  image(canny, src.width, 0);
  image(scharr, 0, src.height);
  image(sobel, src.width, src.height);
  popMatrix();

  text("Source", 10, 25); 
  text("Canny", video.width/2 + 10, 25); 
  text("Scharr", 10, video.height/2 + 25); 
  text("Sobel", video.width/2 + 10, video.height/2 + 25);
}
