class Place {
  String name;
  Location loc;
  String country;
  PImage img;
  
  Place(String temp_name, String temp_country, Location temp_loc, PImage temp_img){
    name = temp_name;
    country = temp_country;
    loc = temp_loc;
    img = temp_img;
    img.resize(180,180);

  }
  
  void display(float x, float y){
      pushMatrix();
      if (x > width - 200 && y < height - 255){
        translate(x-200, y);
      }
      if (x > width - 200 && y > height - 255){
        translate(x-200, y-255);
      }
      if (x < width - 200 && y > height - 255){
        translate(x, y-255);
      }
      if (x < width - 200 && y < height - 255){
        translate(x, y);
      }
      fill(200,200,255);
      noStroke();
      rect(0, 0, 200, 260);
      textSize(20);
      fill(0);
      text(name, 10, 30);
      textSize(15);
      text(country, 10, 50);
      image(img, 10, 70);
      popMatrix();
  }
}
    
