PImage original;
PImage sketchlook;
int dif_max = 0;

void setup(){
  size(912, 912);
  original = loadImage("original.png");
  sketchlook = createImage(912, 912, RGB);
}

void draw(){
  original.loadPixels();
  sketchlook.loadPixels();
  for (int i = 0; i < 912*912; i++){
    float r_o = red(original.pixels[i]);
    float g_o = green(original.pixels[i]);
    float b_o = blue(original.pixels[i]);
    float dif_pix = r_o + g_o + b_o;
    if (dif_pix > dif_max){
      sketchlook.pixels[i] = color(0, 0, 0);
    }
    else {
      sketchlook.pixels[i] = color(255,255,255);
    }
  }
 

  sketchlook.updatePixels();
  image(sketchlook, 0, 0);
  saveFrame("/niñocw/niño_####.png");
  dif_max += 1;
  if (dif_max == 255*3+1){
    noLoop();
  }
}
