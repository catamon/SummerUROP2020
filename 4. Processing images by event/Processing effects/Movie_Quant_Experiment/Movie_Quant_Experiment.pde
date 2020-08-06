import processing.video.*;

Movie original;
Effects quantEff;
int factor = 3;
PImage show;

void setup(){
  size(720,1280);
  original = new Movie(this, "baru.mov");
  show = createImage(width, height, RGB);
  original.play();
}

void movieEvent(Movie movie) {  
  movie.read();
}

void draw(){
  image(original,0,0);
  /*
  original.loadPixels();
  show.loadPixels();
  for (int i = 0; i < width*height; i++){
    quantEff = new Effects(original.pixels[i], factor);
    color newPix = quantEff.quant();
    println(original.pixels[i]);
    show.pixels[i] = newPix;
  }
  image(show,0,0);
  */
}
