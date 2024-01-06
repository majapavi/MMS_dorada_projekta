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

void prikaziDruguIgru() {
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
/// provjera kraja

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


/// detekcija pokreta, kreiranje plocica

//kreiranje dvije pločice s kojima se udara loptica
void nacrtajPlocicu() {
  fill(boja1);
  rect(lijevaL, lijevaV, debljina, visina);
  fill(boja2);
  rect(desnaD, desnaV, debljina, visina);
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


/// odbijanje

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
