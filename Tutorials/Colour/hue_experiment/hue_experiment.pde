
int h = 0;
int h_opp = 255;


void setup() {
  size(600,200);
  background(0);
  colorMode(HSB);
  noStroke();
}


void draw() {
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
  saveFrame("/photos/hue_change.###.png");
}
