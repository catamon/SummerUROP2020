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
function mouseReleased(){
  textSize(20);
  fill(0);
  text("the colour is yellow", pmouseX, pmouseY);
}

function mouseOut(){
  background(255,255,0);
  textSize(30);
  fill(0);
  text("GO BACK TO THE SCREEN!", 10,200);
}
function doubleClicked(){
  saveCanvas("flag.png");
}
