

void controlScreen(){
  pushMatrix();
  translate(video.width,0);
  colorMode(RGB);
  fill(0);
  rectMode(CORNERS);
  rect(0,0,width,height);
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(255);
  text("FILTERS", sqWidth/2,40);
  noStroke();
  fill(70,120,255);
  rectMode(CENTER);
  rect(sqWidth/2,110,sqWidth-40,60);
  rect(sqWidth/2,190,sqWidth-40,60);
  rect(sqWidth/2,270,sqWidth-40,60);
  rect(sqWidth/2,350,sqWidth-40,60);
  rect(sqWidth/2,430,sqWidth-40,60);
  fill(255);
  textSize(20);
  text("BRIGHTNESS", sqWidth/2,110);
  text("CIRCLES", sqWidth/2,190);
  text("CONTOURS", sqWidth/2,270);
  text("MOVEMENT", sqWidth/2,350);
  text("QUANTIZE", sqWidth/2,430);
  popMatrix();
  
  
}
