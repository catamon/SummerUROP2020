PImage casanare;
PImage cabo;
PImage comb;

void setup(){
  size(1000,666);
  comb = createImage(3456,2304,RGB);
  casanare = loadImage("casanare_atardecer.JPG");
  cabo = loadImage("cabo.JPG");
  noLoop();
}

void draw(){
  casanare.loadPixels();
  cabo.loadPixels();
  comb.loadPixels();
  for (int loc=0; loc<7962624; loc++){
    float r_cas = red(casanare.pixels[loc]);
    float g_cas = green(casanare.pixels[loc]);
    float b_cas = blue(casanare.pixels[loc]);
    
    float r_cab = red(cabo.pixels[loc]);
    float g_cab = green(cabo.pixels[loc]);
    float b_cab = blue(cabo.pixels[loc]);
    
    float r_comb;
    float g_comb;
    float b_comb;
    float r_try;
    float g_try;
    float b_try;
    
    if (keyPressed == false){
      r_comb = (r_cas+r_cab)/2;
      g_comb = (g_cas+g_cab)/2;
      b_comb = (b_cas+b_cab)/2;
      comb.pixels[loc] = color(r_comb, g_comb, b_comb);
    }
    else {
      if (key == 'a') {
        r_try = r_cab;
        g_try = g_cab;
        b_try = b_cab;
      }
      else {
        r_try = r_cas;
        g_try = g_cas;
        b_try = b_cas;
      }
      if (r_try<128){
        r_comb = 0;
      }
      else {
        r_comb = 255;
      }
      if (g_try<128){
        g_comb = 0;
      }
      else {
        g_comb = 255;
      }
      if (b_try<128){
        b_comb = 0;
      }
      else {
       b_comb = 255;
      }
      comb.pixels[loc] = color(r_comb, g_comb, b_comb);
      }
      }
  comb.updatePixels();
      
  image(comb,0,0,1000,666);
    
}

void keyPressed(){
  redraw();
  saveFrame("brightness_test2.png");
}

void mousePressed(){
  saveFrame("new_image.jpg");
}
