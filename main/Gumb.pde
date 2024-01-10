//// definiranje gumbova na raznim ekranima
Gumb postavke = new Gumb( 500, 650, "POSTAVKE");

// Pocetni zaslon
Gumb jedanIgrac = new Gumb( 150, 300, "SKUPI LOPTICE\n(1 igrač)" );
Gumb dvaIgraca = new Gumb( 350, 300, "PONG\n(2 igrača)");
Gumb pravila = new Gumb( 250, 440, "PRAVILA" );

// Zaslon postavki
Gumb mute = new Gumb( 350, 200, "MUSIC OFF");
Gumb unmute = new Gumb( 150, 200, "MUSIC ON");
Gumb soundOn = new Gumb( 150, 350, "SOUND ON");
Gumb soundOff = new Gumb( 350, 350, "SOUND OFF");

// Zasloni prije igara
Gumb igraj = new Gumb(270, 500, "IGRAJ!");
Gumb nazad = new Gumb(270, 650, "NAZAD");

// Zasloni za kraj igre
Gumb ponovno = new Gumb( 150, 500, "IGRAJ \nPONOVO" );
Gumb izbornik = new Gumb( 350, 500, "POČETNI \nIZBORNIK" );

class Gumb {

  float x, y;
  float w, h;
  float textSize;
  color rectColor;
  String text;
  int pomaknut;
  float xPom, yPom;
  int sivi;

  // Gumbi s tekstom velicine 160x100
  Gumb(float x_, float y_, String text_) {
    x = x_;
    y = y_;
    w = 160;
    h = 100;
    text = text_;
    textSize = 25;  // defaultna velicina
    rectColor = crvena;
    pomaknut = 0;
    sivi = 0;
  }

  // npr. za crtanje gumba sa slikom, npr. mute
  Gumb(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    text = "";
    textSize = 25;
    rectColor = color(181, 172, 153);
  }

  // Crtaj na početnim koordinatama i u defaultnoj crvenoj boji
  void nacrtajGumb() {
    fill(rectColor);
    rect(x, y, w, h);
    fill(color(0)); // defaultna boja teksta
    textAlign(CENTER, CENTER);
    textSize(textSize);
    text(text, x + w / 2, y + h / 2);
    pomaknut = 0;
    sivi = 0;
  }

  // Crtaj ga pomaknutog
  void nacrtajGumb( float x_, float y_ ) {
    fill(rectColor);
    rect(x_, y_, w, h);
    fill(color(0)); // defaultna boja teksta
    textAlign(CENTER, CENTER);
    textSize(textSize);
    text(text, x_ + w / 2, y_ + h / 2);
    pomaknut = 1;
    xPom = x_;
    yPom = y_;
    sivi = 0;
  }

  // Crtaj sa zadanom bojom
  void nacrtajGumb(color boja) {
    fill(boja);
    rect(x, y, w, h);
    fill(color(0)); // defaultna boja teksta
    textAlign(CENTER, CENTER);
    textSize(textSize);
    text(text, x + w / 2, y + h / 2);
    pomaknut = 0;
    sivi = 1;
  }

  //detektira je li mis unutar gumba
  boolean unutar() {
    if (sivi == 1)
      return false;
    if (pomaknut == 0) {
      if (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h)
        return true;
      else
        return false;
    } else {
      if (mouseX >= xPom && mouseX <= xPom + w && mouseY >= yPom && mouseY <= yPom + h)
        return true;
      else
        return false;
    }
  }

  void prikaziSliku(String slika) { //npr candy.png, pozvat gumb.prikaziSliku("candy.png")
    // potencijalno maskirat..
    image(loadImage(slika), x, y, w, h); // po mogucnosti dodat dimenzije slike td se ne izoblici
  }
}
