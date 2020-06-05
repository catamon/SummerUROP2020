import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Transparency_experiment extends PApplet {


int h = 0;
int h_opp = 255;


public void setup() {
  
  background(0);
  colorMode(HSB);
  noStroke();
}


public void draw() {
  if (h < 256) {
    background(h, 255,255);
    fill(h_opp, 255,255);
    rect(100,50,400,100);
  }
  else {
    background(255);
    exit();
  }
  fill(0,0,0);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("HBS Animation",300,100);
  h += 1;
  h_opp -= 1;
}
  public void settings() {  size(600,200); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Transparency_experiment" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
