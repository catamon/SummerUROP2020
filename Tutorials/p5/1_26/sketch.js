let img;
let smallPoint, largePoint;

function preload() {
  img = loadImage('test2.jpg');
}

function setup() {
  createCanvas(720, 500);
  smallPoint = 10;
  largePoint = 40;
  imageMode(CENTER);
  noStroke();
  background(0);
  img.loadPixels();
}

function draw() {
  let pointillize = map(random(width), 0, width, smallPoint, largePoint);
  let x = floor(random(img.width));
  let y = floor(random(img.height));
  let pix = img.get(x, y);
  fill(pix, 128);
  rect(x, y, pointillize, pointillize);
  fill(255);
  text("1.25.20", 50, height - 40);
}
