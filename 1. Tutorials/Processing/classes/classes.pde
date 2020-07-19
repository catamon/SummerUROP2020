Car[] cars = new Car[256];



void setup(){
  size(1000,1000);
  for (int i= 0; i <255; i = i+1) {
    cars[i] = new Car(color(i, 255 -i, 0), 0, 0, 10, 10);
  }
}


void draw() {
  for (int i= 0; i <255; i = i+1) {
    cars[i].display();
    cars[i].drive();
  }
}
  

class Car {
  
  color c;
  float xpos;
  float ypos;
  float xspeed;
  float yspeed;
  
  Car(color tempc, float tempxpos, float tempypos, float tempxspeed, float tempyspeed) {
    c = tempc;
    xpos = tempxpos;
    ypos = tempypos;
    xspeed = tempxspeed;
    yspeed = tempyspeed;
  }
  
  void display() {
    background(255);
    rectMode(CENTER);
    fill(c);
    rect(xpos, ypos, 10, 10);
  }
  
  void drive() {
    xpos = xpos + xspeed;
    ypos = ypos + yspeed;
    if (xpos > width) {
      xpos = 0;
    }
    if (ypos > height) {
      ypos = 0;
    }
  }
}
