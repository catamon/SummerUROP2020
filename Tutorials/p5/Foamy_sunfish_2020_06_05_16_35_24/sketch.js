function setup() {
  createCanvas(400, 400);
}

function draw() {
  if (mouseIsPressed) {
    fill(0,0,0,128);
  }
  else {
    fill(255,255,0);
  }
  if (keyIsPressed) {
    noFill();
  }
  ellipse(mouseX,mouseY,80,80);
}
