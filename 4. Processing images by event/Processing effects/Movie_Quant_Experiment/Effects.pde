class Effects{
  color pixel;
  int factor;
  
  Effects(color tempPixel, int tempFactor){
   pixel = tempPixel;
   factor = tempFactor;
  }
  
color quant() {
 float oldRed = red(pixel);
 float oldGreen = green(pixel);
 float oldBlue = blue(pixel);
 
 int newRed = round(oldRed*factor/255)*255/factor;
 int newGreen = round(oldGreen*factor/255)*255/factor;
 int newBlue = round(oldBlue*factor/255)*255/factor;
 
 return color(newRed, newGreen, newBlue);
}
}
