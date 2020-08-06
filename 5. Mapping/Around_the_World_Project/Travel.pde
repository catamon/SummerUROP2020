class Travel {
  //This class will be incharged of creating a marker that travels from a location to another
  Location loc1;
  Location loc2;
  
  Travel(Location loc1Temp, Location loc2Temp){
    loc1 = loc1Temp;
    loc2 = loc2Temp;
  }
  
  void display(){
    ScreenPosition pos1 = map.getScreenPosition(loc1);
    ScreenPosition pos2 = map.getScreenPosition(loc2);
    float locDistance = dist(pos1.x, pos1.y, pos2.x, pos2.y); 
    pushMatrix();
    translate(pos1.x, pos1.y);
    rotate(atan((pos1.y-pos2.y)/(pos1.x-pos2.x)));
    noFill();
    stroke(255,255,0);
    strokeWeight(5);
    float amp = map(0.2, 0,1,0,locDistance);
    for (int i=0; i < locDistance; i++){
    float y = -amp*sin(i*PI/locDistance);
    int factor = 1;
    if (pos1.x > pos2.x){
      factor = -1;}
      point(factor*i,y);
    }

    
    popMatrix();
    
  }
  
  
}
