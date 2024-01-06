import controlP5.*; // Koristimo Textfield iz biblioteke controlC5.
import ddf.minim.*; // Koristimo biblioteku Minim za dodavanje zvuka

// Dodavanje varijabli za zvuk
Minim minim;
AudioPlayer pozadinskaMuzika;
//Zvukovi za prvu igru
AudioSample dolazakNaRangListu;
AudioSample krajIgre;
// Zvukovi za drugu igru
AudioSample udaracLopticeUZid;
AudioSample udaracLopticeUPlocicu;

// Funkcija koja se poziva na kraju izvodenja programa i koja zavrsava izvodenje glazbe
void stop(){
  pozadinskaMuzika.close();
  minim.stop();
  super.stop();
}

ControlP5 cp5;
// Potrebni Textfieldovi.
// Za prvu igru.
Textfield igra1_igrac;
// Za drugu igru. //<>//
Textfield igra2_igrac1, igra2_igrac2;

// Imena igrač(a).
String igrac = "Igrač";  // Za prvu igru.
// Za drugu igru.
String igrac1 = "Igrač 1";
String igrac2 = "Igrač 2";

// Podaci potrebni za rang listu.
Table rang;
int rangPlasiranog; // Je li se igrač plasirao na rang listu (top 10).

PImage pozadina;

// Određivanje trenutno odabranog prozora.
// pocetni = 0; prva igra = 1; druga igra = 2; povratak = 3, 4; pravila = 5;
// upis imena za prvu igru = 11; upis imena za drugu igru = 21;
int prozor = 0;

//funkcija koja provjerava jesmo li prošli preko nekog dijela prozora
boolean prelazak (int x, int y, int width, int height){
  if (mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height)
    return true;
  return false;
}


void setup(){
  //najprije postavljamo veličinu i pozadinu koje su uvijek iste
  size(700, 800);
  pozadina = loadImage("pozadina.jpg");
  pozadina.resize(700, 800);
  
  // Kreiraj novu instancu ControlP5-a.
  cp5 = new ControlP5(this);
  
  // Tablica za rang listu.
  rang = loadTable("data/rang.csv", "header");
  // Tablica još ne postoji, treba je stvoriti.
  if (rang == null) {
    rang = new Table();
    rang.addColumn("igrac");
    rang.addColumn("rezultat");
    rang.addColumn("vrijeme");
    
    saveTable(rang, "data/rang.csv");    
  }
  rang.setColumnType("rezultat", Table.INT);
  rang.setColumnType("vrijeme", Table.INT);
  rang.sortReverse(1);
  
  // Font NerkoOne preuzet s GoogleFontsa.
  PFont NerkoOne = createFont("NerkoOne-Regular.ttf", 40);
  textFont(NerkoOne);
  
  // Postavljanje atributa Textfielda za upis imena igrača.
  igra1_igrac = cp5.addTextfield("igra1_igracName")
     .setPosition(150, 350)
     .setSize(400, 70)
     .setVisible(false)
     .setColor(color(255, 255, 153))
     .setColorActive(color(255, 255, 153))
     .setColorForeground(color(255))
     .setColorBackground(color(0))
     .setFont(NerkoOne)
     .setText("Igrač 1");
     
  igra2_igrac1 = cp5.addTextfield("igra1_igrac1Name")
     .setPosition(150, 200)
     .setSize(400, 70)
     .setVisible(false)
     .setColor(color(255, 255, 153))
     .setColorActive(color(255, 255, 153))
     .setColorForeground(color(255))
     .setColorBackground(color(0))
     .setFont(NerkoOne)
     .setText("Igrač 1");
     
    igra2_igrac2 = cp5.addTextfield("igra1_igrac2Name")
     .setPosition(150, 350)
     .setSize(400, 70)
     .setVisible(false)
     .setColor(color(255, 255, 153))
     .setColorActive(color(255, 255, 153))
     .setColorForeground(color(255))
     .setColorBackground(color(0))
     .setFont(NerkoOne)
     .setText("Igrač 2");
  
  // Sakrij sve labele Textfieldova.
  igra1_igrac.getCaptionLabel().setText("");
  igra2_igrac1.getCaptionLabel().setText("");
  igra2_igrac2.getCaptionLabel().setText("");
  
  // Dodavanje pozadinske glazbe
  minim = new Minim(this);
  pozadinskaMuzika = minim.loadFile("Zvuk/pozadinskaMuzika.mp3");
  udaracLopticeUZid = minim.loadSample("Zvuk/udaracLopticeUZid.mp3");
  udaracLopticeUPlocicu = minim.loadSample("Zvuk/udaracLopticeUPlocicu.wav");
  dolazakNaRangListu = minim.loadSample("Zvuk/dolazakNaRangListu.wav");
  krajIgre = minim.loadSample("Zvuk/krajIgre.wav");
  // Pokreće pozadinsku muziku
  pozadinskaMuzika.loop();
  
  osvjeziIgre();
}

// Prilikom pritiska miša provjeravamo koji je prozor
// trenutno odabran te koji je gumb (ako ikoji) prisnut
// u trenutnom prozoru.
void mouseClicked() {
  // Početni prozor.
  if (prozor == 0) {
    // Igraj prvu igru (unos imena igrača).
    if(prelazak(150, 300, 160, 100)) {
        prozor = 11;
        osvjeziIgre();
    }
    // Igraj drugu igru (unos imena igrača).
    if(prelazak(350, 300, 160, 100)) {
      prozor = 21;     
      osvjeziIgre();
    }
    // Pravila.
    if(prelazak(250, 440, 160, 100))
      prozor = 5;
  }
  // Unos imena igrača prije prve igre.
  else if (prozor == 11) {
    // Početak igre -- pritisak gumba "IGRAJ!".
    if (prelazak(270, 500, 160, 100) && igra1_igrac.getText().length() <= 20) {
      prozor = 1;
      igra1_igrac.setVisible(false);
      igrac = igra1_igrac.getText();
      osvjeziIgre(); 
    }
  }
  // Unos imena igrača prije druge igre.
  else if (prozor == 21) {
    // Početak igre -- pritisak gumba "IGRAJ!".
    if (prelazak(270, 500, 160, 100) && igra2_igrac1.getText().length() <= 20 && igra2_igrac2.getText().length() <= 20) {
      prozor = 2;
      igra2_igrac1.setVisible(false);
      igra2_igrac2.setVisible(false);
      igrac1 = igra2_igrac1.getText();
      igrac2 = igra2_igrac2.getText();
      osvjeziIgre(); 
    }
  }
  // Prozor nakon prve igre.
  else if (prozor == 3) {
    // Natrag na početnu stranicu.
    if(prelazak(150, 200, 160, 100)) {
      prozor = 0;
      osvjeziIgre();
    }
    // Igraj ponovno.
    if(prelazak(350, 200, 160, 100)) {
      prozor = 1;
      osvjeziIgre();
    } 
  }
  // Prozor nakon druge igre.
  else if (prozor == 4) {
    // Natrag na početnu stranicu.
    if(prelazak(150, 300, 160, 100)) {
        prozor = 0;
        osvjeziIgre();
      }
      // Igraj ponovno.
      if(prelazak(350, 300, 160, 100)) {
        prozor = 2;
        osvjeziIgre();
      } 
  }
  // Pravila.
  else if (prozor == 5) {
    // Natrag na početnu stranicu.
    if(prelazak(250, 650, 160, 100)) {
      prozor = 0;
      osvjeziIgre();
    } 
  }
}

void draw(){
  //početni prozor
  if(prozor == 0)
  { 
    prikaziPocetniZaslon();
  }
  
  // Upis imena za prvu igru.
  else if (prozor == 11) {
    prijavaPrvaIgra();
  }
  
  //prva igrica
  else if(prozor == 1)
  {
    if(odabranaPrvaIgra)
    {
      prikaziPrvuIgru();
    }
  }
  
  // Upis imena za drugu igru.
  else if (prozor == 21) {
    prijavaDrugeIgre();
  }
  
  //odabrana je druga igrica
  else if(prozor == 2)
  {
    prikaziDruguIgru();
  }
  
  //prozor nakon kraja prve igrice
  else if(prozor == 3)
  {
    prikaziKrajPrveIgre();

  }  
  
  //prozor nakon kraja druge igrice
  else if(prozor == 4)
  {
    prikaziKrajDrugeIgre();
  }
  
  //pravila
  else if(prozor == 5)
  {
    ispisiPravila(); 
  }
}
