int n = -50;


void brightness () {
  opencv.loadImage(video);
  opencv.brightness((int)n);
  image(opencv.getOutput(), 0, 0);

}
