
void drawLines(int x, int y) {
   lines = opencv.findLines(1, 1, 40);
//  image(opencv.getOutput(), w/2, h/2);
  strokeWeight(0.5);
  fill(255);
  rect(x, y, w/2, h/2);
  pushMatrix();
  translate(x, y);
  for (Line line : lines) {
    if (line.angle >= radians(0) && line.angle < radians(1)) {
      stroke(0, 0, 0);
      line(line.start.x, line.start.y, line.end.x, line.end.y);
    }

    if (line.angle > radians(89) && line.angle < radians(91)) {
      stroke(0, 0, 0);
      line(line.start.x, line.start.y, line.end.x, line.end.y);
    }
  }
  popMatrix();
}



void drawLinesInvert(int x, int y) {
   lines = opencv.findLines(1, 1, 40);
//  image(opencv.getOutput(), w/2, h/2);
  strokeWeight(0.5);
  stroke(255);
  fill(0);
  rect(x, y, w/2, h/2);
  pushMatrix();
  translate(x, y);
  for (Line line : lines) {
    if (line.angle >= radians(0) && line.angle < radians(1)) {
      line(line.start.x, line.start.y, line.end.x, line.end.y);
    }

    if (line.angle > radians(89) && line.angle < radians(91)) {
      line(line.start.x, line.start.y, line.end.x, line.end.y);
    }
  }
  popMatrix();
}


void drawLinesAll(int x, int y) {
  strokeWeight(0.5);
  pushMatrix();
  fill(255);
  rect(x, y, w/2, h/2);
  translate(x, y);
  for (Line line : lines) {
      stroke(0);
      line(line.start.x, line.start.y, line.end.x, line.end.y);
  }
  popMatrix();
}



void drawLinesFilled(int x, int y) {
  strokeWeight(0.5);
  pushMatrix();
    fill(255);
  rect(x, y, w/2, h/2);
  translate(x, y);
  ArrayList<Integer> colors = new ArrayList<Integer>();
  for(int i = 0; i<lines.size(); i++){
    colors.add(color(random(255), random(255), random(255), 10));
  }
  for(int i = 0; i<lines.size(); i++){
     Line line = lines.get(i); 
     noStroke();
     fill(colors.get(i));
     rect(line.start.x, line.start.y, line.end.x, line.end.y);
     //rect(line.start.x, line.start.y, 20, 20);

     stroke(0);
     line(line.start.x, line.start.y, line.end.x, line.end.y);
  }
  popMatrix();
}

void drawLinesTriangles(int x, int y) {
  strokeWeight(0.5);
  fill(0);
  rect(x, y, w/2, h/2);
  pushMatrix();
  
  translate(x, y);
  ArrayList<Integer> colors = new ArrayList<Integer>();
  for(int i = 0; i<lines.size(); i++){
    colors.add(color(random(255), random(255), random(255), 10));
  }
  for(int i = 0; i<lines.size(); i++){
     Line line = lines.get(i); 
     noStroke();
     fill(colors.get(i));
     triangle(line.start.x, line.start.y, line.end.x, line.end.y, line.start.x +  line.end.x, line.end.y + line.start.y);
     //rect(line.start.x, line.start.y, 20, 20);

     stroke(0);
     line(line.start.x, line.start.y, line.end.x, line.end.y);
  }
  popMatrix();
}
