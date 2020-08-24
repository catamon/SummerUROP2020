import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 
import gab.opencv.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Integrated extends PApplet {





Capture video;
OpenCV opencv;
String filter = "NULL";
int sqWidth;
Effect none;
Effect q;


public void captureEvent (Capture video) {
  prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  video.read();
}

public void setup() {
  
  video = new Capture(this, 640, 480);
  video.start();
  prev = createImage(640, 480, RGB);
  opencv = new OpenCV(this, video);
  sqWidth = width -video.width;
  qEdit = createImage(640,480, RGB);
}

public void draw() {
  background(0);
  none = new Effect(filter);
  controlScreen();
  getCenter(filter);
  
}

public void mousePressed() {
  if ((660 < mouseX) && (mouseX < 960)) {
    if ((80 < mouseY) && (mouseY < 140)) {
      filter = "BRIGHTNESS";
    }
    if ((160 < mouseY) && (mouseY < 220)) {
      filter = "CIRCLES";
    }
    if ((240 < mouseY) && (mouseY < 300)) {
      filter = "CONTOURS";
    }
    if ((320 < mouseY) && (mouseY < 380)) {
      filter = "MOVEMENT";
    }
    if ((400 < mouseY) && (mouseY < 460)) {
      filter = "QUANT";
    }
  
  }
}
int n = -50;


public void brightness () {
  opencv.loadImage(video);
  opencv.brightness((int)n);
  image(opencv.getOutput(), 0, 0);

}
int maxD = 20;


public void circles(int maxD){
  colorMode(RGB);
  noStroke();
  fill(0,0,255);
  background(255);
  video.loadPixels();
  for (int x = 0; x < video.width; x += maxD){
    for (int y = 0; y < video.height; y += maxD){
      float total = 0;
      for (int sqX = 0; sqX < maxD; sqX++){
        for (int sqY = 0; sqY < maxD; sqY++){
          int loc = x + sqX + (y + sqY) * video.width;
          int pix = video.pixels[loc];
          total += (red(pix)+green(pix)+blue(pix))/(3* maxD*maxD);
        }
      }
      float r = map(total, 0, 255,maxD, 0);
      ellipse(x+maxD/2, y+maxD/2, r, r);
    }
  }
}
      
ArrayList<Contour> contours;
int hue = 0;

public void contours(){
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
class Effect{
  String filter;

Effect(String name_){
  filter = name_;
  textSize(20);
  if (filter == "QUANT"){
    quant(factor);
  }
  if (filter == "MOVEMENT"){
    movement(threshold);
  }
  if (filter == "BRIGHTNESS"){
    brightness();
  }
  if (filter == "CIRCLES"){
    circles(maxD);
  }
  if (filter == "CONTOURS"){
    contours();
  }
  if (filter == "NULL"){
    image(video, 0, 0);
  }
  
  if (filter != "null"){
  

  }
}

}
PImage prev;
int threshold = 70;

public void movement(int thr){

  strokeWeight(1);
  colorMode(HSB);
  background(0);
  video.loadPixels();
  prev.loadPixels();
  for (int x = 0; x < video.width; x++){
    for (int y = 0; y < video.height; y++){
      if (y < 256){
        hue = y;
      }
      else{
        hue = y-255;
      }
      stroke(hue,255,255);
      int loc = x + y*video.width;
      int currentColor = video.pixels[loc];
      int prevColor = prev.pixels[loc];
      float d = dist(red(currentColor), green(currentColor), blue(currentColor), red(prevColor), green(prevColor), blue(prevColor));
      if (d > thr){
        point(x,y);
      }
    }
  }
}
int factor = 4;
PImage qEdit;

public void quant(int factor){
  qEdit.loadPixels();
  colorMode(RGB);
  strokeWeight(1);
  background(0);
  video.loadPixels();
  for (int x = 0; x < video.width; x++){
    for (int y = 0; y < video.height; y++){
      int loc = x + y*video.width;
      int pix = video.pixels[loc];
      float newR = round(red(pix)*factor/255)*255/factor;
      float newG = round(green(pix)*factor/255)*255/factor;
      float newB = round(blue(pix)*factor/255)*255/factor;
      int newPix = color(newR, newG, newB);
      /*
      stroke(newPix);
      point(x,y);
      */
      qEdit.pixels[loc] = newPix;
    }
  }
  qEdit.updatePixels();
  image(qEdit,0,0);
}
      

public void controlScreen() {
  pushMatrix();
  translate(video.width, 0);
  colorMode(RGB);
  fill(0);
  rectMode(CORNERS);
  rect(0, 0, width, height);
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(255);
  text("FILTERS", sqWidth/2, 40);
  noStroke();
  fill(70, 120, 255);
  rectMode(CENTER);
  rect(sqWidth/2, 110, sqWidth-40, 60);
  rect(sqWidth/2, 190, sqWidth-40, 60);
  rect(sqWidth/2, 270, sqWidth-40, 60);
  rect(sqWidth/2, 350, sqWidth-40, 60);
  rect(sqWidth/2, 430, sqWidth-40, 60);
  fill(255);
  textSize(20);
  text("BRIGHTNESS", sqWidth/2, 110);
  text("CIRCLES", sqWidth/2, 190);
  text("CONTOURS", sqWidth/2, 270);
  text("MOVEMENT", sqWidth/2, 350);
  text("QUANTIZE", sqWidth/2, 430);
  popMatrix();
}

public void getCenter(String filter) {
  rectMode(CENTER);
  if (filter == "BRIGHTNESS") {
    darken(810, 110);
    n = amount(n, 810, 110, -255, 255, 5);
  }
  if (filter == "CIRCLES") {
    darken(810, 190);
    text(filter, 810, 190);
  }
  if (filter == "CONTOURS") {
    darken(810, 270);
    text(filter, 810, 270);
  }
  if (filter == "MOVEMENT") {
    darken(810, 350);
    text(filter, 810, 350);
  }
  if (filter == "QUANT") {
    darken(810, 430);
    factor = amount(factor, 810, 430, 1, 8, 1);
  }
}

public void darken(float x, float y) {
  fill(35, 60, 128);
  stroke(255);
  strokeWeight(2);
  rect(x, y, 300, 60);
  fill(255);
}

public int amount (int element, float x, float y, int minEl, int maxEl, int add) {
  fill(255);
  rect(x, y, 40, 30);
  triangle(x+30, y+10, x+30, y-10, x+50, y);
  triangle(x-30, y+10, x-30, y-10, x-50, y);
  fill(0);
  textSize(15);
  text(element, x, y);
  if (mousePressed == true) {
    delay(100);
    if ((x-50 < mouseX && mouseX < x-30) && (y-10 < mouseY && mouseY < y+10) && (minEl < element)){
      element -=add;
    }
    if ((x+30 < mouseX && mouseX < x+50) && (y-10 < mouseY && mouseY < y+10) && (element < maxEl)){
      element +=add;
  }
}
return element;
}
  public void settings() {  size(980, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Integrated" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
