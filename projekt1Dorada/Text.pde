// klasa za jednostavnije ispisivanje teksta na ekran
class Text {
  float x, y;
  int textSize;
  String text;
  color textColor;

  Text(float x_, float y_, int textSize_, String text_, color textColor_) {
    x = x_;
    y = y_;
    textSize = textSize_;
    text = text_;
    textColor = textColor_;
  }

  //defaultna crna boja i velicina teksta 30
  Text(float x_, float y_, String text_) {
    x = x_;
    y = y_;
    textSize = 30;
    text = text_;
    textColor = color(0);
  }

  void ispisiText() {
    fill(textColor);
    textAlign(CENTER, CENTER);
    textSize(textSize);
    text(text, x, y);
  }
}

// pomocna funkcija za ispis vremena u formatu mm:ss
String pretvoriVrijeme(int t) {
  String vrijeme;
  int minute, sekunde;
  sekunde = t/1000;
  minute = sekunde/60;
  sekunde = sekunde - minute*60;

  if ( minute < 10 )
    vrijeme = "0"+minute;
  else
    vrijeme = ""+minute;

  vrijeme = vrijeme + ":";

  if ( sekunde < 10 )
    vrijeme = vrijeme + "0"+sekunde;
  else
    vrijeme = vrijeme + ""+sekunde;

  return vrijeme;
}
