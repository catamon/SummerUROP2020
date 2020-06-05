function setup() {
  createCanvas(400, 400);
}

function draw() {
  if (mouseIsPressed) {
    fill(0,0,0,128);
    ellipse(mouseX,mouseY,80,80);
  }
  else {
    fill(255,255,0);

    if (keyIsPressed) {
      noFill();
      if (key == "b"){
        fill(0,0,255, 128);
      }
      if (key == "r"){
        fill(255,0,0,128);
      }
    }
    rectMode(CENTER);
    rect(mouseX,mouseY,80,80);
  }

}
