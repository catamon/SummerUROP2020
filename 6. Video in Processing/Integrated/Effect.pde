class Effect{
  String filter;

Effect(String name_){
  name_ = filter;
  textSize(20);
  pushMatrix();
  if (filter == "QUANT"){
    quant(factor);
    translate(sqWidth/2, 430);
  }
  if (filter == "MOVEMENT"){
    movement(threshold);
  }
  if (filter == "BRIGHTNESS"){
    brightness();
  }
  if (filter == "CIRCLES"){
    circles(maxD);
  }
  if (filter == "CONTOURS"){
    contours();
  }
  if (filter == "NULL"){
    image(video, 0, 0);
  }
  
  if (filter != "null"){
  
  fill(35,60,128);
  rect(0,0,sqWidth-40,60);
  fill(255);
  text(filter, 0,0);
  }
  popMatrix();
}

}
