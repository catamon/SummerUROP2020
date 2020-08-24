int maxD = 20;


void circles(int maxD){
  colorMode(RGB);
  noStroke();
  fill(0,0,255);
  background(255);
  video.loadPixels();
  for (int x = 0; x < video.width; x += maxD){
    for (int y = 0; y < video.height; y += maxD){
      float total = 0;
      for (int sqX = 0; sqX < maxD; sqX++){
        for (int sqY = 0; sqY < maxD; sqY++){
          int loc = x + sqX + (y + sqY) * video.width;
          color pix = video.pixels[loc];
          total += (red(pix)+green(pix)+blue(pix))/(3* maxD*maxD);
        }
      }
      float r = map(total, 0, 255,maxD, 0);
      ellipse(x+maxD/2, y+maxD/2, r, r);
    }
  }
}
      
