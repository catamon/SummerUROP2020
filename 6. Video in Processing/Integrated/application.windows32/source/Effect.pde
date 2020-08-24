class Effect{
  String filter;

Effect(String name_){
  filter = name_;
  textSize(20);
  if (filter == "QUANT"){
    quant(factor);
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
  

  }
}

}
