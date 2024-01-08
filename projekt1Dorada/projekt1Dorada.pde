import controlP5.*; // Koristimo Textfield iz biblioteke controlC5.
import ddf.minim.*; // Koristimo biblioteku Minim za dodavanje zvuka

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
// pocetni = 0; prva igra = 1; druga igra = 2; povratak = 3, 4; pravila = 5; postavke = 6;
// upis imena za prvu igru = 11; upis imena za drugu igru = 21;
int prozor = 0;
int prethodniProzor = 0;

// definiranje korištenih boja
color zuta = color(255, 255, 153);
color bijela = color (255, 255, 255);
color crvena = color(185, 59, 59);
color siva = color(120, 120, 120);


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
  
  // potrebno za evidenciju trajanja igre
  prosloVrijeme = 0;
}

// Prilikom pritiska miša provjeravamo koji je prozor
// trenutno odabran te koji je gumb (ako ikoji) prisnut
// u trenutnom prozoru.
void mouseClicked() {
  // Zapamti prethodni prozor da se mozes vratiti nazad
  if(prozor != 6)
    prethodniProzor = prozor;
  // Postavke
  if ( postavke.unutar() ){
    prozor = 6;
  }
  
  // Početni prozor.
  if (prozor == 0) {
    // Igraj prvu igru (unos imena igrača).
    if( jedanIgrac.unutar() ){
        prozor = 11;
    }
    // Igraj drugu igru (unos imena igrača).
    if( dvaIgraca.unutar() ){
      prozor = 21;
    }
    // Pravila.
    if( pravila.unutar() ){
      prozor = 5;
    }
    
  }
  // Unos imena igrača prije prve igre.
  else if (prozor == 11) {
    // Početak igre -- pritisak gumba "IGRAJ!".
    if ( igraj.unutar() && igra1_igrac.getText().length() <= 14) {
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
    if ( igraj.unutar() && igra2_igrac1.getText().length() <= 14 && igra2_igrac2.getText().length() <= 14) {
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
    if( ponovno.unutar() ){ 
      prozor = 1;
      osvjeziIgre();
    }
    // Natrag na početnu stranicu.
    if( izbornik.unutar() ){ 
      prozor = 0;
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
    }
  }
  // Pravila.
  else if (prozor == 5) {
    // Natrag na početnu stranicu.
    if( nazad.unutar() ){
      prozor = 0;
    } 
  }
  // Postavke.
  else if (prozor == 6){
    igra1_igrac.setVisible(false);
    igra2_igrac1.setVisible(false);
    igra2_igrac2.setVisible(false);
    
    /// POSTAVKE ZVUKA
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
    
    /// NAVIGACIJA
    // Nazad na prethodni prozor.
    if( nazad.unutar() ){
      prozor = prethodniProzor;
      vrijemePocetka = millis();
    }
    // Resetiraj igru.
    if( ponovno.unutar() ){ 
      prozor = prethodniProzor;
      osvjeziIgre();
      bodovi1 = 0; 
      bodovi2 = 0;
      p = 0;
    }
    // Natrag na početnu stranicu.
    if( izbornik.unutar() ){ 
      prozor = 0;
    }
  }
}

// Prilikom igranja igre, provjeravamo je li pritisnuta tipka za postavke ili za drugu igru
void keyPressed() {
  // Zapamti prethodni prozor da se mozes vratiti nazad
  if(prozor != 6)
    prethodniProzor = prozor;
  
  // Otvaranje postavki tijekom igranja igre
  if (key == 'p' || key == 'P') {
    prozor = 6;
    if(prethodniProzor == 1){
      prosloVrijeme = prosloVrijeme + ( millis() - vrijemePocetka );
    }
  }
  
  // Ispituj ostale tipke za igranje druge igre
  pritisnutaTipka();
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
  
  //postavke
  else if(prozor == 6)
  {
    prikaziPostavke();
  }
  
}
