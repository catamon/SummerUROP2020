/* Example for halftone an image to get a old school print look.
 * 
 * The dot size can be changed by moving the mouse left and right.
 * The spacing between the dots can be changed by moving the mouse up and down.
 * If you press the mouse button the dots will be shown in a grid. 
 *  
 * Author: Nick 'Milchreis' Müller
 */

import milchreis.imageprocessing.*;

PImage image;

void drawHalfTone(int x, int y){
  // dotsize by mouseX
  int dotsize = 7;
  
  // dots in grid or honeycomb style
  boolean inGrid = false;
  
  // Foreground color
  int foreground = color(168, 50, 113);
  
  // Space between dots by mouseY
  int space = 3;
  
  // Draw image
  image(Halftone.apply(video, dotsize, foreground, 255, space, inGrid), x, y);
}
