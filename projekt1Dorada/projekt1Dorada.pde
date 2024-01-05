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

//za prvu igricu
int brojZivota = 0;
int collisionCooldown = 0;
int radijus = 50;
int rezultat;
boolean odabranaPrvaIgra;
boolean kraj;
Loptica[] protiv;
Loptica dohvati;
int vrijemePocetka, vrijemeKraja, trajanjeIgre;
color blue = color(0, 0, 255), green = color(0, 255, 0), red = color(255, 0, 0), purple = color(128,0,128);
int powerUpCount = 0;
Loptica[] powerUps;


//za drugu igricu
int visinaLop, sirinaLop;
float lopticax, lopticay, brzinax, brzinay;
int lijevaL, lijevaV, debljina, visina, pomak;
int desnaD, desnaV;
boolean doleL, doleD, goreL, goreD;
color boja1 = color(255, 255, 153);
color boja2 = color (255, 255, 255);
int bodovi1 = 0; 
int bodovi2 = 0;
int p = 0;


//kreiranje dvije pločice s kojima se udara loptica
void nacrtajPlocicu() {
  fill(boja1);
  rect(lijevaL, lijevaV, debljina, visina);
  fill(boja2);
  rect(desnaD, desnaV, debljina, visina);
}

//udarac loptice u bočne strane ili gornju i donju
void provjeriOdbijanjeLoptice() {
  // bocne strane
 if ( lopticax > width - sirinaLop/2)
 {
    osvjeziIgre();
    brzinax = -brzinax;
    bodovi1 = bodovi1 + 1;
    udaracLopticeUZid.trigger();
  }
  else if ( lopticax < 0 + sirinaLop/2)
  {
    udaracLopticeUZid.trigger();
    osvjeziIgre();
    bodovi2 = bodovi2 + 1;
  }
  // gornja i donja strana
  if ( lopticay > height - visinaLop/2)
  {
    brzinay = -brzinay;
  }
  else if ( lopticay < 0 + visinaLop/2)
  {
    brzinay = -brzinay;
  }
}

//ispisivanje rezultata
void ispisiRezultat() {
  textSize(30);
  fill(boja1);
  textAlign(LEFT);
  text(igrac1, 20, 50);
  text(bodovi1, 20, 80);
  fill(boja2);
  textAlign(RIGHT);
  text(igrac2, width-20, 50);
  text(bodovi2, width-20, 80);
}
 
//određivanje kada smo došli do kraja igrice
void provjeriKraj() 
{
  if(bodovi1 == 5) {
    prozor = 4;
    bodovi1=0; 
    bodovi2=0;
    p=1;
  }
  if(bodovi2 == 5) {
    prozor = 4;
    bodovi1=0;
    bodovi2=0;
    p=2;
  }
}

void keyPressed() {
if (key == 'w' || key == 'W') {
    goreL = true;
  }
  if (key == 's' || key == 'S') {
    doleL = true;
  }
  if (keyCode == UP) {
    goreD = true;
  }
  if (keyCode == DOWN) {
    doleD = true;
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    goreL = false;
  }
  if (key == 's' || key == 'S') {
    doleL = false;
  }
  if (keyCode == UP) {
    goreD = false;
  }
  if (keyCode == DOWN) {
    doleD = false;
  }
}

//pomicanje pločice gore ili dole
void pomakniPlocicu(){
  if (goreL) {
    lijevaV = lijevaV - pomak;
  }
  if (doleL) {
    lijevaV = lijevaV + pomak;
  }
  if (goreD) {
    desnaV = desnaV - pomak;
  }
  if (doleD) {
    desnaV = desnaV + pomak;
  }
}

//gledamo je li pločica možda došla do vrha ili dna
void plocicaUZid() {
  if (lijevaV - visina/100 < 0) {
    lijevaV = lijevaV + pomak;
  }
  if (lijevaV + visina > height) {
    lijevaV = lijevaV - pomak;
  }
  if (desnaV - visina/100 < 0) {
    desnaV = desnaV + pomak;
  }
  if (desnaV + visina > height) {
    desnaV = desnaV - pomak;
  }
}

//provjeravamo je li loptica udarila o pločicu
void dodir() {
  if (lopticax - sirinaLop/2 < lijevaL + debljina && lopticay - visinaLop/2 < lijevaV + visina/2 && lopticay + visinaLop/2 > lijevaV - visina/2 ) {
    if (brzinax < 0) {
      udaracLopticeUPlocicu.trigger();
      brzinax = -(brzinax-0.2);
    }
  }
  else if (lopticax + sirinaLop/2 > desnaD && lopticay - visinaLop/2 < desnaV + visina/2 && lopticay + visinaLop/2 > desnaV - visina/2 ) {
    if (brzinax > 0) {
      udaracLopticeUPlocicu.trigger();
      brzinax = -(brzinax+0.2);
    }
  }
}

//funkcija koja provjerava jesmo li prošli preko nekog dijela prozora
boolean prelazak (int x, int y, int width, int height){
  if (mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height)
    return true;
  return false;
}

// Ažurira rang listu nakon završetka prve igre.
void updateRangTable() {
  vrijemeKraja = millis();
  trajanjeIgre = vrijemeKraja - vrijemePocetka;
  print(trajanjeIgre + "\n");
  int brojRedaka = rang.getRowCount();
  // Rang tablica bi već trebala biti sortirana silazno po broju bodova.
  if (brojRedaka < 10) {
    TableRow redak = rang.addRow();
    redak.setString("igrac", igrac);
    redak.setInt("rezultat", rezultat);
    redak.setInt("vrijeme", trajanjeIgre);

    rang.sortReverse(1);
    

    rangPlasiranog = 1;
    TableRow novi_redak;
    for (TableRow redak_temp : rang.rows())
    {
      if(redak_temp.getInt("rezultat") == rezultat && redak_temp.getInt("vrijeme") == trajanjeIgre)
        break;
      rangPlasiranog += 1;
    }

    
    dolazakNaRangListu.trigger();
    
    saveTable(rang, "data/rang.csv");
  }
  else
  {
    TableRow zadnjiRedak = rang.getRow(brojRedaka-1);
    if (zadnjiRedak.getInt("rezultat") < rezultat
      || (zadnjiRedak.getInt("rezultat") == rezultat && zadnjiRedak.getInt("vrijeme") > trajanjeIgre))
    {
      // Obriši zadnjeg.
      rang.removeRow(brojRedaka-1);
      // Dodaj novog.
      TableRow redak = rang.addRow();
      redak.setString("igrac", igrac);
      redak.setInt("rezultat", rezultat);  
      redak.setInt("vrijeme", trajanjeIgre);

      rang.sortReverse(1);
  
  
      rangPlasiranog = 1;
      TableRow novi_redak;
      for (TableRow redak_temp : rang.rows())
      {
        if(redak_temp.getInt("rezultat") == rezultat && redak_temp.getInt("vrijeme") == trajanjeIgre)
          break;
        rangPlasiranog += 1;
      }

      
      dolazakNaRangListu.trigger();
      saveTable(rang, "data/rang.csv");
    }
    // U protivnom, igrač se nije plasirao i ne radimo ništa.
    else
    {
      rangPlasiranog = -1;
      krajIgre.trigger();
    }
  } 
}

void prikaziRangListu(float startY) {
  int i = 1;
  textSize(30);
  textAlign(LEFT);
  
  for (TableRow row : rang.rows()) {
    fill(255, 255, 153);
    text(i + ".    " + row.getString("igrac") + "    " + row.getInt("rezultat") + " bodova    " + row.getInt("vrijeme") + " milisekundi", 100, startY+(40*i));
    ++i;
  }
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

void osvjeziIgre() {
  //odabrana je prva igrica, 
  if(prozor == 1)
  {
    rezultat = 0;
    brojZivota = 3;
    odabranaPrvaIgra = true;
    vrijemePocetka = millis();
    dohvati = napraviLopticuBoje(green);
    protiv = new Loptica[50];
    protiv[0] = napraviLopticu();
  }
  
  //odabrana je druga igrica
  if(prozor == 2)
  {
    lopticax = width/2; 
    lopticay = height/2;
    visinaLop = 50;
    sirinaLop = 50;
    brzinax = 3;
    brzinay = 3;

    debljina = 30;
    visina = 100;
    lijevaL = 40;
    lijevaV = height/2;
    desnaD = width-40-debljina;
    desnaV = height/2;
    pomak = 5;
  }
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
    background(pozadina);
    nacrtajLopticu();
    pomakniLopticu();
    provjeriOdbijanjeLoptice();
    nacrtajPlocicu();
    pomakniPlocicu();
    plocicaUZid();
    dodir();
    ispisiRezultat();
    provjeriKraj();
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


void prikaziPocetniZaslon() {
  background(pozadina);
  
  fill(255, 255, 153);
  textSize(60);
  text("Igrice s lopticom", 330, 100);
   
  // 1 IGRAČ
  fill(185, 59, 59);
  rect(150, 300, 160, 100);
  
  // 2 IGRAČA
  fill(185, 59, 59);
  rect(350, 300, 160, 100);
  
  // PRAVILA
  fill(185, 59, 59);
  rect(250, 440, 160, 100);
  

  fill(0, 0, 0);
  textAlign(CENTER, CENTER);
  textSize(25);
  //tri buttona 
  text("SKUPI LOPTICE\n(1 igrač)", 230, 350);
  text("PONG\n(2 igrača)", 430, 350);
  text("PRAVILA", 330, 490);
}

void ispisiPravila() {
  background(pozadina);
      
    fill(boja1);
    textSize(40);
    textAlign(CENTER);
    text("Skupi loptice (1 igrač)", 350, 70);
    textSize(30);
    fill(boja2);
    text("U ovoj igrici, vi ste crvena loptica. \nPomičući miša, mičete svoju lopticu. \nCilj je tom lopticom dotaknuti što više zelenih. \nSa svakom dotaknutom zelenom lopticom, \nbroj plavih se povećava.\nIgra je gotova kada dotaknete plavu lopticu", 350, 120);
   
    fill(boja1);
    textSize(40);
    textAlign(CENTER);
    text("Pong (2 igrača)", 350, 420);
    textSize(30);
    fill(boja2);
    text("Cilj ove igrice je poslati protivniku \nlopticu tako da je on ne može vratiti. \nPobjednik je onaj igrač kojem to 5 puta \npođe za rukom.", 350, 470);
 
    fill(185, 59, 59);
    rect(250, 650, 160, 100); 

    fill(0, 0, 0);
    textAlign(CENTER, CENTER);
    textSize(25);
    text("NAZAD", 330, 700);
}


void prijavaPrvaIgra() {
    background(pozadina);
    
    igra1_igrac.setVisible(true).setFocus(true);
    
    fill(255, 255, 153);
    textAlign(CENTER);
    textSize(70);
    text("Upišite ime:", 350, 300);
    
    
    // Gumb "Igraj!" s kojim započinje igra nakon upisa
    // imena.
    
    Gumb igraj = new Gumb(270, 500, 160, 100, "IGRAJ!", color(185, 59, 59));
    igraj.nacrtajGumb();
    igraj.prikaziSliku("candy.png");
    
    if (igra1_igrac.getText().length() > 20) {
      fill(185, 59, 59);
      textAlign(CENTER, CENTER);
      textSize(30);
      text("Ime smije sadržavati najviše 20 znakova!", 350, 450);
    }
}

void prikaziPrvuIgru() {
  {
      background(pozadina);
    
      fill(255, 255, 255);
      textSize(30);
      text("Rezultat: " + rezultat, 80, 40);
      
      fill(255, 255, 255);
      textSize(30);
      text("Broj zivota: " + brojZivota, width - 120, 40);
      
      //crvena loptica koja je uvijek tamo gdje je miš
      fill(red);
      ellipse(mouseX, mouseY, dohvati.radius, dohvati.radius);
      
      //zelena loptica koju trebamo uhvatiti
      fill(dohvati.boja);
      ellipse(dohvati.x, dohvati.y, dohvati.radius, dohvati.radius);

      dohvati.update();
    
      //plave loptice koje ne smijemo udariti
      for(int i = 0; i<rezultat +1; i++)
      {
        protiv[i].update();
        fill(protiv[i].boja);
        ellipse(protiv[i].x, protiv[i].y, protiv[i].radius, protiv[i].radius);
        
        //dotakli smo plavu
        if (dist(mouseX, mouseY, protiv[i].x, protiv[i].y) < protiv[i].radius && collisionCooldown <=0 )
        {
          brojZivota -= 1;
          print("broj zivota" + brojZivota);
          if (brojZivota > 0){
            
            protiv[i].postaviNoveKoordinate();
          } else if (brojZivota == 0){
           odabranaPrvaIgra = false;
           updateRangTable();          
           prozor = 3;
           radijus = 50; // inace se broji od zadnje zapamcene vrijednosti
          } 
          collisionCooldown = 20;
         
        }        
      }

      //dotakli smo zelenu
      if (dist(mouseX, mouseY, dohvati.x, dohvati.y) < dohvati.radius)
      {
        rezultat++;
        protiv[rezultat] = napraviLopticu();
        dohvati.postaviNoveKoordinate(); // td ne mijenja velicinu zelene i crvene loptice
      }
      
     // dodat powerupse 
     if (rezultat > 0 && rezultat % 4 == 0 && powerUpCount == 0) {
        powerUps = new Loptica[1];
        powerUps[0] = napraviLopticuBoje(purple); 
        powerUpCount += 1; 
      }
     // prikazat powetupse
     for(int i = 0; i < powerUpCount; i++){
        fill(powerUps[i].boja);
        ellipse(powerUps[i].x, powerUps[i].y, powerUps[i].radius, powerUps[i].radius);    
     }
     
     if (collisionCooldown > 0) {
        collisionCooldown--;
      }
    
    }
}

void prikaziKrajPrveIgre() {
  background(pozadina);
    
  fill(255, 255, 153);
  textSize(60);
  textAlign(CENTER);
  text("Osvojili ste " + rezultat + " loptica.", 350, 100);
  
  // Prikaži rang listu.
  textSize(30);
  if (rangPlasiranog != -1 && rezultat != 0)
   {
     text("Bravo, " + igrac +"!\nOsvojili ste mjesto " + rangPlasiranog + " na rang listi.", 350, 140);
   }
    
  textSize(50);
  text("Rang lista", 350, 350);
  prikaziRangListu(360);
  
  fill(185, 59, 59);
  rect(150, 200, 160, 100);
   
  fill(185, 59, 59);
  rect(350, 200, 160, 100);
    

  fill(0, 0, 0);
  textAlign(CENTER, CENTER);
  textSize(25);
  text("IGRAJ \nPONOVO", 430, 250);
  text("POČETNI \nIZBORNIK", 230, 250);
}

void prijavaDrugeIgre() {
  background(pozadina);
    
  igra2_igrac1.setVisible(true);
  igra2_igrac2.setVisible(true);
  
  fill(255, 255, 153);
  textAlign(CENTER);
  textSize(70);
  text("Upišite imena:", 350, 150);
  
  // Gumb "Igraj!" s kojim započinje igra nakon upisa
  // imena.
  fill(185, 59, 59);
  rect(270, 500, 160, 100);
  
  fill(0, 0, 0);
  textAlign(CENTER, CENTER);
  textSize(25);
  text("IGRAJ!", 350, 550);
  
  if (igra2_igrac1.getText().length() > 20) {
    fill(185, 59, 59);
    textAlign(CENTER, CENTER);
    textSize(30);
    text("Ime smije sadržavati najviše 20 znakova!", 350, 300);
  }
  
  if (igra2_igrac2.getText().length() > 20) {
    fill(185, 59, 59);
    textAlign(CENTER, CENTER);
    textSize(30);
    text("Ime smije sadržavati najviše 20 znakova!", 350, 450);
  }
}

void prikaziKrajDrugeIgre() {
    background(pozadina);
      
    fill(255, 255, 153);
    textSize(60);
    textAlign(CENTER);
    text("Kraj igre!", 350, 100);
    text("Pobijedio je igrač", 350, 170);
    if (p == 1)
      text(igrac1, 350, 240);
    else if (p == 2)
      text(igrac2, 350, 240);
    
    //gumbovi
    fill(185, 59, 59);
    rect(150, 300, 160, 100);
     
    fill(185, 59, 59);
    rect(350, 300, 160, 100);
      
    fill(0, 0, 0);
    textAlign(CENTER, CENTER);
    textSize(25);
    text("IGRAJ \nPONOVO", 430, 350);
    text("POČETNI \nIZBORNIK", 230, 350);
}
