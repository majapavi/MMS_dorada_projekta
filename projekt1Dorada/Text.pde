class Text {
  float x, y;
  int textSize;
  String text; 
  color textColor;
  
  Text(float x_, float y_, int textSize_, String text_, color textColor_){
    x = x_;
    y = y_;
    textSize = textSize_;
    text = text_;
    textColor = textColor_;
  }
  
  // // defaultna crna boja
  //Text(float x_, float y_, int textSize_, String text_){
  //  x = x_;
  //  y = y_;
  //  textSize = textSize_;
  //  text = text_;
  //  textColor = color(0);
  //}
  
  // Text(float x_, float y_, String text_, color textColor_){
  //  x = x_;
  //  y = y_;
  //  textSize = 30;
  //  text = text_;
  //  textColor = textColor_;
  //}
  
  //defaultna crna boja i velicina texta
  Text(float x_, float y_, String text_){
    x = x_;
    y = y_;
    textSize = 30;
    text = text_;
    textColor = color(0);
  }
  
  void ispisiText() {
    fill(textColor); // defaultna boja teksta 
    textAlign(CENTER, CENTER);
    textSize(textSize);
    text(text, x, y);
  }
  
}

Text pretvoriVrijeme(int min, int sec){
  String minuta, sekundi;
  if( min < 10 ){
    minuta = "0"+min;
  }
  else {
    minuta = ""+min;
  }
  if( sec < 10 ){
    sekundi = "0"+sec;
  }
  else {
    sekundi = ""+sec;
  }
  Text vrijeme = new Text( width/2, 20, 30, minuta + ":" + sekundi, bijela);
  return vrijeme;
}
