PImage glitch;

void scanLines(int x, int y){    
    opencv.loadImage(video);
    opencv.threshold(100);
    glitch = opencv.getOutput();
    int scanlinesHeight = 1;
    int alpha = 90;
    image(Scanlines.apply(glitch, scanlinesHeight, alpha), x, y);
}
