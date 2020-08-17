int n = -255;
int i = -1;


void brightness() {
  if ((n==255)||(n==-255)) {
    i= i*-1;
  }
  opencv.loadImage(video);
  opencv.brightness((int)n);
  image(opencv.getOutput(), 0, 0);

  n = n+i;
}
