PImage original;
PImage edges;
PImage transform;
float[] r_difs;
float[] g_difs;
float[] b_difs;
int num_loops = 0;
int n = 100;

void setup(){
  size(1080,1080);
  transform = loadImage("original.png");
  original = loadImage("original.png");
  edges = loadImage("edges2.png");
  r_difs = new float[1080*1080];
  g_difs = new float[1080*1080];
  b_difs = new float[1080*1080];
  original.loadPixels();
  edges.loadPixels();
  for (int i=0; i<1080*1080; i++){
    float r_o = red(original.pixels[i]);
    float g_o = green(original.pixels[i]);
    float b_o = blue(original.pixels[i]);
    float r_e = red(edges.pixels[i]);
    float g_e = green(edges.pixels[i]);
    float b_e = blue(edges.pixels[i]);
    float r_dif = (r_e-r_o)/n;
    float g_dif = (g_e-g_o)/n;
    float b_dif = (b_e-b_o)/n;
    r_difs[i] = r_dif;
    g_difs[i] = g_dif;
    b_difs[i] = b_dif;
  }
}

void draw(){
  // original.loadPixels();
  // edges.loadPixels();
  transform.loadPixels();
  for (int i=0; i<1080*1080; i++){
    float r_initial = red(transform.pixels[i]);
    float g_initial = green(transform.pixels[i]);
    float b_initial = blue(transform.pixels[i]);
    float r_dif = r_difs[i];
    float g_dif = g_difs[i];
    float b_dif = b_difs[i];
    float r_final = r_initial + r_dif;
    float g_final = g_initial + g_dif;
    float b_final = b_initial + b_dif;
    transform.pixels[i] = color(r_final,g_final,b_final);
  }
  transform.updatePixels();
  image(transform, 0, 0);
  saveFrame("t esta/tranform_####.png");
}
  
