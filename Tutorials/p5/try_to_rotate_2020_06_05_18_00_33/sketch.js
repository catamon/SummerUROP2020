let max_width =100;
let w = 100;
let doing = "dec";

function setup() {
  createCanvas(400, 400);

}

function draw() {
  background(255);
  rectMode(CENTER);
  fill(0,0,255, 255-w*3/2);

  rect(200,200,w,100);

  if (doing == "dec"){
    w -=1;
  }
  if (doing == "inc"){
    w +=1;
  }
  if (w <= 0){
    doing = "inc";
  }
  if (w >= 100){
    doing = "dec";
  }
  }
