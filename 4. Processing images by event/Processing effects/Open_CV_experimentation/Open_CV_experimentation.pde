import gab.opencv.*;

PImage src, dst;
OpenCV opencv;

ArrayList<Contour> contours;
ArrayList<Contour> polygons;

void setup() {
  src = loadImage("original2.png"); 
  size(1080, 810);
  background(0);
  opencv = new OpenCV(this, src);

  opencv.gray();
  opencv.threshold(70);
  dst = opencv.getOutput();

  contours = opencv.findContours();
  colorMode(HSB);
}

void draw() {
  //image(src, 0, 0);

  noFill();
  strokeWeight(3);
  
  for (Contour contour : contours) {
    stroke(255);
    contour.draw();
    
    
    int n = 0;
    stroke(255);
    beginShape();
    for (PVector point : contour.getPolygonApproximation().getPoints()) {
      //if (n%2 == 0){stroke(255,0,0);}
     //else{stroke(255,255,0);}
     stroke(10*n,255,255);
      vertex(point.x, point.y);
      n +=1;
      if (n > 255){ n=0;}
      println(n);
    }
    endShape();
  }
  save("HSBcasa.png");
  noLoop();
}
