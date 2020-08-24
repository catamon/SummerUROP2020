
void controlScreen() {
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

void getCenter(String filter) {
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

void darken(float x, float y) {
  fill(35, 60, 128);
  stroke(255);
  strokeWeight(2);
  rect(x, y, 300, 60);
  fill(255);
}

int amount (int element, float x, float y, int minEl, int maxEl, int add) {
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
