ArrayList<Contour> contours;
int hue = 0;

void contours(){
  colorMode(HSB);

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
