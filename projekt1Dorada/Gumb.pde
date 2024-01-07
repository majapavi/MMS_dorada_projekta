//// definiranje gumbova na raznim ekranima
Gumb postavke = new Gumb( 600, 20, "POSTAVKE");

// Pocetni zaslon
Gumb jedanIgrac = new Gumb( 150, 200, "SKUPI LOPTICE\n(1 igrač)" );
Gumb dvaIgraca = new Gumb( 350, 200, "PONG\n(2 igrača)");
Gumb pravila = new Gumb( 250, 340, "PRAVILA" );
Gumb mute = new Gumb( 150, 480, "MUTE");

// Zaslon postavki
Gumb unmute = new Gumb( 350, 480, "UNMUTE");
Gumb soundOn = new Gumb( 150, 620, "SOUND ON");
Gumb soundOff = new Gumb( 350, 620, "SOUND OFF");

// Zasloni prije igara
Gumb igraj = new Gumb(270, 500, "IGRAJ!");
Gumb nazad = new Gumb(270, 650, "NAZAD");

// Za prvu igru
Gumb igrajPonovno = new Gumb(150, 220, "IGRAJ \nPONOVO");
Gumb pocetniIzbornik = new Gumb(350, 220, "POČETNI \nIZBORNIK" );

// Za drugu igru
Gumb ponovno = new Gumb( 150, 500, "IGRAJ \nPONOVO" );
Gumb izbornik = new Gumb( 350, 500, "POČETNI \nIZBORNIK" );

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
  
  
  //Gumb(float x_, float y_, float w_, float h_, String text_) {
  //  x = x_;
  //  y = y_;
  //  w = w_;
  //  h = h_;
  //  text = text_;
  //  textSize = 25;  // defaultna velicina
  //  rectColor = crna; //crvena
  //}
  
  //Gumb(float x_, float y_, float w_, float h_, float textSize_, String text_) {
  //  x = x_;
  //  y = y_;
  //  w = w_;
  //  h = h_;
  //  text = text_;
  //  textSize = textSize_; 
  //  rectColor = color(255, 0, 0);
  //}
  
  //Gumb(float x_, float y_, float w_, float h_, String text_, color rectColor_) {
  //  x = x_;
  //  y = y_;
  //  w = w_;
  //  h = h_;
  //  text = text_;
  //  textSize = 25;
  //  rectColor = rectColor_;
  //}
  
  //Gumb(float x_, float y_, float w_, float h_, float textSize_, String text_, color rectColor_) {
  //  x = x_;
  //  y = y_;
  //  w = w_;
  //  h = h_;
  //  text = text_;
  //  textSize = textSize_;
  //  rectColor = rectColor_;
  //}
 
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
  
  //detektira je li mis unutar gumba
  boolean unutar(){
    if (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h)
      return true;
    return false;
  }
  
  void prikaziSliku(String slika){
    //fill(rectColor); 
    //rect(x, y, w, h);
    // potencijalno maskirat.. 
    image(loadImage(slika), x, y, w, h); //  + ".png" dat (pozeljne/skalirane) dimenzije slike td se ne izoblici
  }
}
