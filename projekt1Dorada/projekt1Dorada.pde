import controlP5.*; // Koristimo Textfield iz biblioteke controlC5.
import ddf.minim.*; // Koristimo biblioteku Minim za dodavanje zvuka

//// Dodavanje varijabli za zvuk
//Minim minim;
//AudioPlayer pozadinskaMuzika;
////Zvukovi za prvu igru
//AudioSample dolazakNaRangListu;
//AudioSample krajIgre;
//// Zvukovi za drugu igru
//AudioSample udaracLopticeUZid;
//AudioSample udaracLopticeUPlocicu;
//int music = 1;
//int sound = 1;

//// Funkcija koja se poziva na kraju izvodenja programa i koja zavrsava izvodenje glazbe
//void stop(){
//  pozadinskaMuzika.close();
//  minim.stop();
//  super.stop();
//  music = 0;
//}

ControlP5 cp5;
// Potrebni Textfieldovi.
// Za prvu igru.
Textfield igra1_igrac;
// Za drugu igru. //<>//
Textfield igra2_igrac1, igra2_igrac2;

// Imena igrač(a).
// Za prvu igru.
String igrac = "Igrač";  
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

// definiranje korištenih boja
color zuta = color(255, 255, 153);
color bijela = color (255, 255, 255);
color crna = color(185, 59, 59);

//// definiranje gumbova na raznim ekranima
// Pocetni zaslon
Gumb jedanIgrac = new Gumb( 150, 200, "SKUPI LOPTICE\n(1 igrač)" );
Gumb dvaIgraca = new Gumb( 350, 200, "PONG\n(2 igrača)");
Gumb pravila = new Gumb( 250, 340, "PRAVILA" );
Gumb mute = new Gumb( 150, 480, "MUTE");
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


// Početne postavke pri pokretanju
void setup(){
  //najprije postavljamo veličinu i pozadinu koje su uvijek iste
  size(700, 800);
  pozadina = loadImage("svemir.jpg");
  pozadina.resize(700, 800);
  
  // Kreiraj novu instancu ControlP5-a.
  cp5 = new ControlP5(this);
  
  // Tablica za rang listu.
  rang = loadTable("data/rang.csv", "header");
  // Ako tablica još ne postoji, treba je stvoriti.
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
     .setColor(zuta)
     .setColorActive(zuta)
     .setColorForeground(color(255))
     .setColorBackground(color(0))
     .setFont(NerkoOne)
     .setText("Igrač 1");
     
  igra2_igrac1 = cp5.addTextfield("igra1_igrac1Name")
     .setPosition(150, 200)
     .setSize(400, 70)
     .setVisible(false)
     .setColor(zuta)
     .setColorActive(zuta)
     .setColorForeground(color(255))
     .setColorBackground(color(0))
     .setFont(NerkoOne)
     .setText("Igrač 1");
     
    igra2_igrac2 = cp5.addTextfield("igra1_igrac2Name")
     .setPosition(150, 350)
     .setSize(400, 70)
     .setVisible(false)
     .setColor(zuta)
     .setColorActive(zuta)
     .setColorForeground(color(255))
     .setColorBackground(color(0))
     .setFont(NerkoOne)
     .setText("Igrač 2");
  
  // Sakrij sve labele Textfieldova.
  igra1_igrac.getCaptionLabel().setText("");
  igra2_igrac1.getCaptionLabel().setText("");
  igra2_igrac2.getCaptionLabel().setText("");
  
  setupZvuka();
  //// Dodavanje pozadinske glazbe
  //minim = new Minim(this);
  //pozadinskaMuzika = minim.loadFile("Zvuk/pozadinskaMuzika.mp3");
  //udaracLopticeUZid = minim.loadSample("Zvuk/udaracLopticeUZid.mp3");
  //udaracLopticeUPlocicu = minim.loadSample("Zvuk/udaracLopticeUPlocicu.wav");
  //dolazakNaRangListu = minim.loadSample("Zvuk/dolazakNaRangListu.wav");
  //krajIgre = minim.loadSample("Zvuk/krajIgre.wav");
  //// Pokreće pozadinsku muziku
  //pozadinskaMuzika.loop();
  //music = 1;
  
  //osvjeziIgre(); -> nepotrebno jer je prozor = 0 uvijek, a fja sluzi za osvjezavanje igre 1 odnosno 2, tj kad je prozor jednak 1 odn 2 
}

// Prilikom pritiska miša provjeravamo koji je prozor
// trenutno odabran te koji je gumb (ako ikoji) prisnut
// u trenutnom prozoru.
void mouseClicked() {
  // Početni prozor.
  if (prozor == 0) {
    // Igraj prvu igru (unos imena igrača).
    if( jedanIgrac.unutar() ){  // if(prelazak(150, 300, 160, 100)) {
        prozor = 11;
        //osvjeziIgre(); -> također nepotrebno jer nece biti prozor jednak ni 1 ni 2
    }
    // Igraj drugu igru (unos imena igrača).
    if( dvaIgraca.unutar() ){  //if(prelazak(350, 300, 160, 100)) {
      prozor = 21;     
      //osvjeziIgre(); -> također nepotrebno jer nece biti prozor jednak ni 1 ni 2
    }
    // Pravila.
    if( pravila.unutar() ){  //if(prelazak(250, 440, 160, 100))
      prozor = 5;
    }
    // Mute button
    if( mute.unutar() && music == 1){
      pozadinskaMuzika.pause();
      music = 0;
    }
    if( unmute.unutar() && music == 0){
      pozadinskaMuzika.loop();
      music = 1;
    }
    // Gumb za uključivanje/isključivanje popratnih zvukova
    if( soundOff.unutar() && sound == 1){
      sound = 0;
    }
    if( soundOn.unutar() && sound == 0){
      sound = 1;
    }
  }
  // Unos imena igrača prije prve igre.
  else if (prozor == 11) {
    // Početak igre -- pritisak gumba "IGRAJ!".
    if ( igraj.unutar() && igra1_igrac.getText().length() <= 20) {
      prozor = 1;
      igra1_igrac.setVisible(false);
      igrac = igra1_igrac.getText();
      osvjeziIgre(); 
    }
    else if(nazad.unutar() ){  // Vrati se na početni izbornik
      prozor = 0;
      igra1_igrac.setVisible(false);
    }
  }
  // Unos imena igrača prije druge igre.
  else if (prozor == 21) {
    // Početak igre -- pritisak gumba "IGRAJ!".
    if ( igraj.unutar() && igra2_igrac1.getText().length() <= 20 && igra2_igrac2.getText().length() <= 20) {
      prozor = 2;
      igra2_igrac1.setVisible(false);
      igra2_igrac2.setVisible(false);
      igrac1 = igra2_igrac1.getText();
      igrac2 = igra2_igrac2.getText();
      osvjeziIgre(); 
    }
    else if(nazad.unutar() ){  // Vrati se na početni izbornik
      prozor = 0;
      igra2_igrac1.setVisible(false);
      igra2_igrac2.setVisible(false);
    }
  }
  // Prozor nakon prve igre.
  else if (prozor == 3) {
    // Igraj ponovno.
    if( igrajPonovno.unutar() ){ 
      prozor = 1;
      osvjeziIgre();
    }
    // Natrag na početnu stranicu.
    if( pocetniIzbornik.unutar() ){ 
      prozor = 0;
      //osvjeziIgre(); -> također nepotrebno jer nece biti prozor jednak ni 1 ni 2
    }
  }
  // Prozor nakon druge igre.
  else if (prozor == 4) {
    // Igraj ponovno.
    if( ponovno.unutar() ){ 
      prozor = 2;
      osvjeziIgre();
    }
    // Natrag na početnu stranicu.
    if( izbornik.unutar() ){ 
      prozor = 0;
      //osvjeziIgre(); -> također nepotrebno jer nece biti prozor jednak ni 1 ni 2
    }
  }
  // Pravila.
  else if (prozor == 5) {
    // Natrag na početnu stranicu.
    if( nazad.unutar() ){  //if(prelazak(250, 650, 160, 100)) {
      prozor = 0;
      //osvjeziIgre(); -> također nepotrebno jer nece biti prozor jednak ni 1 ni 2
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
    //if(odabranaPrvaIgra)  // nepotrebni if?
    //{
      prikaziPrvuIgru();
    //}
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
