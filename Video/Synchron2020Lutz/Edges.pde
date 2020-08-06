//import gab.opencv.*;

//OpenCV opencv;
PImage scharr;

void drawEdges(int x, int y){
  opencv.findScharrEdges(OpenCV.VERTICAL);
  scharr = opencv.getSnapshot();
  image(scharr, x, y);
}
