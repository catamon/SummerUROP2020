/*
1.18.20 
Nina Lutz 

Filter combining contours with lines

Changes as faces are detected 

*/

void drawFilter1(int x, int y){ 
 drawContoursArt(x, y);
 drawLinesAll(x, y); 
}

void drawFilter2(int x, int y){
  drawContoursRainbow(x, y);
  pushMatrix();
  translate(x, y);
  stroke(0);
  strokeWeight(2);
  noFill();
  opencv.drawOpticalFlow();
  strokeWeight(0.5);
  popMatrix();
}

void drawFilter3(int x, int y){
  drawLinesFilled(x, y);
}


void drawFilter4(int x, int y){
  pushMatrix();
  translate(x, y);
  stroke(0);
  strokeWeight(2);
  noFill();
  opencv.drawOpticalFlow();
  strokeWeight(0.5);

  for (Line line : lines) {
      stroke(random(255), random(255), random(255));
      line(line.start.x, line.start.y, line.end.x, line.end.y);
  }
  popMatrix();
}
