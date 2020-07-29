class Dither{
  color pixel;
  int factor;
  
  Dither(color tempPixel, int tempFactor){
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
  
  float[] findError(){
    color newPixel = quant();
   float oldRed = red(pixel);
   float oldGreen = green(pixel);
   float oldBlue = blue(pixel);
   float newRed = red(newPixel);
   float newGreen = green(newPixel);
   float newBlue = blue(newPixel);
   float[] Error = {oldRed - newRed, oldGreen - newGreen, oldBlue - newBlue};
   return Error;
  }
  
  
  color applyError(color pixel, float fraction, float[] error){
     float rError = error[0];
     float gError = error[1];
     float bError = error[2];
     float r = red(pixel);
     float g = green(pixel);
     float b = blue(pixel);
     r += rError*fraction;
     g += gError*fraction;
     b += bError*fraction;
     return color(r,g,b);
}
   
    
   
    
}
