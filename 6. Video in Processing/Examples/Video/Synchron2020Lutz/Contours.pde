import java.util.*;

void drawContours(int x, int y){
  pushMatrix();
  translate(x, y);
  fill(255);
  rect(x, y, w/2, h/2);
  ArrayList<Integer> colors = new ArrayList<Integer>();
  for(int i = 0; i <contours.size(); i++){
    colors.add(color(random(255), random(255), random(255)));
  }
  for(int i = 0; i <contours.size(); i++){
      stroke(0, 255, 0);
      contours.get(i).draw();
      //fill(colors.get(i));
      noFill();
      stroke(255, 0, 0);
      beginShape();
      for (PVector point : contours.get(i).getPolygonApproximation().getPoints()) {
        vertex(point.x, point.y);
      }
      endShape();
    }
    popMatrix();
}

void drawContoursRainbow(int x, int y){
  pushMatrix();
  translate(x, y);
  ArrayList<Integer> colors = new ArrayList<Integer>();
  for(int i = 0; i <contours.size(); i++){
    colors.add(color(random(255), random(255), random(255)));
  }
  for(int i = 0; i <contours.size(); i++){
      stroke(0, 255, 0);
      contours.get(i).draw();
      fill(colors.get(i));
      stroke(255, 0, 0);
      beginShape();
      for (PVector point : contours.get(i).getPolygonApproximation().getPoints()) {
        vertex(point.x, point.y);
      }
      endShape();
    }
    popMatrix();
}


void drawContoursRainbow2(int x, int y){
  fill(255);
  rect(x, y, w/2, h/2);
  pushMatrix();
  translate(x, y);
  ArrayList<Integer> colors = new ArrayList<Integer>();
  for(int i = 0; i <contours.size(); i++){
    colors.add(color(random(255), random(255), random(255)));
  }
  for(int i = 0; i <contours.size(); i++){
      stroke(0, 255, 0);
      contours.get(i).draw();
      fill(colors.get(i));
      stroke(255, 0, 0);
      beginShape();
      for (PVector point : contours.get(i).getPolygonApproximation().getPoints()) {
        vertex(point.x, point.y);
      }
      endShape();
    }
    popMatrix();
}

void drawContoursArt(int x, int y){
  pushMatrix();
  translate(x, y);
  for(int i = 0; i <contours.size(); i++){
    stroke(0);
    contours.get(i).draw();
    fill(i, 200, 200);
    stroke(255, 0, 0);
    beginShape();
    for (PVector point : contours.get(i).getPolygonApproximation().getPoints()) {
      vertex(point.x, point.y);
    }
    endShape();
  }
  popMatrix();
}

void drawContoursWild(int x, int y){
  fill(255);
  rect(x, y, w/2, h/2);
  pushMatrix();
  translate(x, y);
  for(int i = 0; i <contours.size(); i++){
      noStroke();
      for (PVector point : contours.get(i).getPolygonApproximation().getPoints()) {
        float c = map(point.y, 0, h/2, 0, 255);
        fill(0, c, 0, 10);
        int diam = (int) map(point.x, 0, w/2, 5, 40);
        ellipse(point.x, point.y, diam, diam);
      }
    }
    popMatrix();
}



void drawContoursEcho(int x, int y){
  pushMatrix();
  translate(x, y);
  ArrayList<Integer> colors = new ArrayList<Integer>();
  for(int i = 0; i <contours.size(); i++){
    colors.add(color(random(255), random(255), random(255)));
  }
  for(int i = 0; i <contours.size(); i++){
    
      stroke(random(255), random(255), random(255));
      contours.get(i).draw();
      //fill(colors.get(i));
      noFill();
      
      beginShape();
      for (PVector point : contours.get(i).getPolygonApproximation().getPoints()) {
        vertex(point.x, point.y);
      }
      endShape();
    }
    popMatrix();
}


void drawContoursFilter2(int x, int y){
    fill(255);
  rect(x, y, w/2, h/2);
  pushMatrix();
  translate(x, y);
  ArrayList<Integer> colors = new ArrayList<Integer>();
  for(int i = 0; i <contours.size(); i++){
    colors.add(color(random(255), random(255), random(255), 50));
  }
  for(int i = 0; i <contours.size(); i++){
    
      stroke(255);
      contours.get(i).draw();
      fill(colors.get(i));
      beginShape();
      for (PVector point : contours.get(i).getPolygonApproximation().getPoints()) {
        
          vertex(point.y, point.x);
      }
      endShape();
    }
    popMatrix();
}
