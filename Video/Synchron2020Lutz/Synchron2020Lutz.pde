/*
Nina Lutz 
Synchrony 2020 

A script of simple filters using OpenCV. 
Trying to add more art and expressiveness to OpenCV results.
*/

import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import milchreis.imageprocessing.*;

PImage src, dst;

Capture video;
OpenCV opencv;

ArrayList<Contour> contours;
ArrayList<Line> lines;

int w = 640;
int h = 480;

void setup(){
  //size(1280, 720); 
  size(1600, 960);
 //size(1920,1080);
  video = new Capture(this, w/2, h/2);
  //video = new Capture(this, width, height);
  opencv = new OpenCV(this, w/2, h/2);
  video.start();
}

void draw(){
  background(255);
  
  opencv.calculateOpticalFlow();
  opencv.loadImage(video);
  
  opencv.threshold(70);
  dst = opencv.getOutput();
  contours = opencv.findContours();
   
 // doASCII(0, 0, width, height);
  
  //Row 1: contours, threshold, optic flow, edges, lines
  drawContours(0, 0);
  fill(255);
  rect(w, 0, w/2, h/2);
  image(dst, w/2, 0);
  drawOptics(w, 0);
  drawEdges(3*w/2, 0);
  drawLines(w*2, 0);
  
  //Row 2: filter 1, filter 2, scanLines, rainbow contours, filter 3
  drawFilter1(0, h/2);
  drawFilter2(w/2, h/2);
  scanLines(w, h/2);
  drawContoursRainbow(3*w/2, h/2);
  drawFilter3(w*2, h/2);
  
  //Row 3: Halftone/raster, 
  drawHalfTone(0, h);
  drawFilter4(w, h);
  doASCII(w/2, h);
  drawLinesInvert(3*w/2, h);
  drawContoursRainbow2(w*2, h);
  
  ////Row 4:   
  drawContoursEcho(w/2, 3*h/2);
  drawLinesTriangles(w,  3*h/2);
  image(video, 2*w, 3*h/2);
  drawContoursFilter2(0, 3*h/2);
  drawContoursWild(3*w/2, 3*h/2);
  fill(255, 0, 0);
  textSize(20);
  text(frameRate, width - 100, height - 20);
}

void captureEvent(Capture c) {
  c.read();
}
