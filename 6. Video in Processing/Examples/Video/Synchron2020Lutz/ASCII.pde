
void doASCII(int x, int y){
  PImage asciiImage = ASCII.apply(video);
  image(asciiImage, x, y, w/2, h/2);

}


void doASCII(int x, int y, float h, float w){
  PImage asciiImage = ASCII.apply(video);
  image(asciiImage, x, y, h, w);

}
