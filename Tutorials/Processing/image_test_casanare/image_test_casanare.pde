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
    
    if (keyPressed == false){
      float r_comb = (r_cas+r_cab)/2;
      float g_comb = (g_cas+g_cab)/2;
      float b_comb = (b_cas+b_cab)/2;
    }
    else {
      if (r_cas<128){
        float r_comb = 0;
      }
      else {
        float r_comb = 255;
      }
      if (g_cas<128){
        float g_comb = 0;
      }
      else {
        float g_comb = 255;
      }
      if (b_cas<128){
        float b_comb = 0;
      }
      else {
        float b_comb = 255;
      }
      }
    comb.pixels[loc] = color(r_comb, g_comb, b_comb);
      }
  comb.updatePixels();
      
  image(comb,0,0,1000,666);
    
}

void mousePressed(){
  saveFrame("doble_image.jpg");
}
