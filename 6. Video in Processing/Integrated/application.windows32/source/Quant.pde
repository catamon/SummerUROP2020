int factor = 4;
PImage qEdit;

void quant(int factor){
  qEdit.loadPixels();
  colorMode(RGB);
  strokeWeight(1);
  background(0);
  video.loadPixels();
  for (int x = 0; x < video.width; x++){
    for (int y = 0; y < video.height; y++){
      int loc = x + y*video.width;
      color pix = video.pixels[loc];
      float newR = round(red(pix)*factor/255)*255/factor;
      float newG = round(green(pix)*factor/255)*255/factor;
      float newB = round(blue(pix)*factor/255)*255/factor;
      color newPix = color(newR, newG, newB);
      /*
      stroke(newPix);
      point(x,y);
      */
      qEdit.pixels[loc] = newPix;
    }
  }
  qEdit.updatePixels();
  image(qEdit,0,0);
}
      
