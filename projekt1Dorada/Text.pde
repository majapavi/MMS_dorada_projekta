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

String pretvoriVrijeme(int t){
  String vrijeme;
  int minute, sekunde;
  sekunde = t/1000;
  minute = sekunde/60;
  sekunde = sekunde - minute*60;
  
  if( minute < 10 )
    vrijeme = "0"+minute;
  else
    vrijeme = ""+minute;
  
  vrijeme = vrijeme + ":";
  
  if( sekunde < 10 )
    vrijeme = vrijeme + "0"+sekunde;
  else
    vrijeme = vrijeme + ""+sekunde;
  
  return vrijeme;
}
