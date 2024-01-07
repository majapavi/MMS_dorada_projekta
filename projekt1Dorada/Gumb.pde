class Gumb {
  
  float x, y;
  float w, h; 
  float textSize; 
  color rectColor;
  String text;

  // Gumbi s tekstom velicine 160x100
  Gumb(float x_, float y_, String text_) {
    x = x_;
    y = y_;
    w = 160;
    h = 100;
    text = text_;
    textSize = 25;  // defaultna velicina
    rectColor = crna; //crvena zapravo na crnoj pozadini
  }
  
  
  Gumb(float x_, float y_, float w_, float h_, String text_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    text = text_;
    textSize = 25;  // defaultna velicina
    rectColor = color(255, 0, 0); //crvena
  }
  
  Gumb(float x_, float y_, float w_, float h_, float textSize_, String text_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    text = text_;
    textSize = textSize_; 
    rectColor = color(255, 0, 0);
  }
  
  Gumb(float x_, float y_, float w_, float h_, String text_, color rectColor_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    text = text_;
    textSize = 25;
    rectColor = rectColor_;
  }
  
  Gumb(float x_, float y_, float w_, float h_, float textSize_, String text_, color rectColor_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    text = text_;
    textSize = textSize_;
    rectColor = rectColor_;
  }
 
  // npr. za crtanje gumba sa slikom, npr. mute 
  Gumb(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    text = ""; 
    textSize = 25;  
    rectColor = color(181, 172, 153);  //
  }
 
 
  void nacrtajGumb(){
    fill(rectColor); 
    rect(x, y, w, h);
    fill(color(0)); // defaultna boja teksta 
    textAlign(CENTER, CENTER);
    textSize(textSize);
    text(text, x + w / 2, y + h / 2);
  } 
  
   void prikaziSliku(String slika){
    //fill(rectColor); 
    //rect(x, y, w, h);
    // potencijalno maskirat.. 
    image(loadImage(slika), x, y, w, h); //  + ".png" dat (pozeljne/skalirane) dimenzije slike td se ne izoblici
   }
}
