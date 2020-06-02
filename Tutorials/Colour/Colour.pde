size(600,800);
background(255);
noStroke();

// red scale
fill(255,0,0);
ellipse(300,100,100,100);
fill(192,0,0);
ellipse(200,100,100,100);
fill(128,0,0);
ellipse(100,100,100,100);
fill(255,64,64);
ellipse(400,100,100,100);
fill(255, 128,128);
ellipse(500,100,100,100);

// green scale
fill(0,255,0);
ellipse(300,300,100,100);
fill(0,192,0);
ellipse(200,300,100,100);
fill(0,128,0);
ellipse(100,300,100,100);
fill(64,255,64);
ellipse(400,300,100,100);
fill(128, 255,128);
ellipse(500,300,100,100);

// blue scale
fill(0,0,255);
ellipse(300,500,100,100);
fill(0,0,192);
ellipse(200,500,100,100);
fill(0,0,128);
ellipse(100,500,100,100);
fill(64,64,255);
ellipse(400,500,100,100);
fill(128, 128,255);
ellipse(500,500,100,100);

// yellow scale
fill(255,255,0);
ellipse(300,200,100,100);
fill(192,192,0);
ellipse(200,200,100,100);
fill(128,128,0);
ellipse(100,200,100,100);
fill(255,255,64);
ellipse(400,200,100,100);
fill(255,255,128);
ellipse(500,200,100,100);

// cyan scale
fill(0,255,255);
ellipse(300,400,100,100);
fill(0,192,192);
ellipse(200,400,100,100);
fill(0,128,128);
ellipse(100,400,100,100);
fill(64,255,255);
ellipse(400,400,100,100);
fill(128,255,255);
ellipse(500,400,100,100);

// purple scale
fill(255,0,255);
ellipse(300,600,100,100);
fill(192,0,192);
ellipse(200,600,100,100);
fill(128,0,128);
ellipse(100,600,100,100);
fill(255, 64,255);
ellipse(400,600,100,100);
fill(255,128,255);
ellipse(500,600,100,100);

// text
fill(0);
textSize(80);
text("Colour Scale", 50,750);
point(50,750);

saveFrame("ColourScale.png");
