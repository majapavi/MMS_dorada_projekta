//za drugu igricu
int visinaLop, sirinaLop;
float lopticax, lopticay, brzinax, brzinay;
int lijevaL, lijevaV, debljina, visina, pomak;
int desnaD, desnaV;
boolean doleL, doleD, goreL, goreD;
int bodovi1 = 0;
int bodovi2 = 0;
int p = 0;


void prijavaDrugeIgre() {
  background(pozadina);

  igra2_igrac1.setVisible(true);
  igra2_igrac2.setVisible(true);

  Text ime = new Text (350, 150, 70, "Upišite imena:", zuta);
  ime.ispisiText();

  // Gumb "Igraj!" s kojim započinje igra nakon upisa imena.
  igraj.nacrtajGumb();
  nazad.nacrtajGumb();

  // Provjeri duljinu unesenih imena igrača
  if (igra2_igrac1.getText().length() > 14) {
    Text duljinaUsername = new Text(350, 300, 30, "Ime smije sadržavati najviše 14 znakova!", crvena);
    duljinaUsername.ispisiText();
  }

  if (igra2_igrac2.getText().length() > 14) {
    Text duljinaUsername = new Text(350, 450, 30, "Ime smije sadržavati najviše 14 znakova!", crvena);
    duljinaUsername.ispisiText();
  }

  postavke.nacrtajGumb();
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

  // Proglašenje pobjednika
  String pobjedio = "Kraj igre!\nPobijedio je igrač\n";
  pobjedio = (p == 1) ? pobjedio+igrac1 : pobjedio+igrac2;
  Text pobjednik = new Text(350, 200, 70, pobjedio, zuta);
  pobjednik.ispisiText();

  //gumbovi
  ponovno.nacrtajGumb();
  izbornik.nacrtajGumb();
  postavke.nacrtajGumb();
}

/// provjera kraja

//određivanje kada smo došli do kraja igrice
void provjeriKraj()
{
  if (bodovi1 == 5) {
    prozor = 4;
    bodovi1=0;
    bodovi2=0;
    p=1;
  }
  if (bodovi2 == 5) {
    prozor = 4;
    bodovi1=0;
    bodovi2=0;
    p=2;
  }
}

//napravi lopticu na početnoj lokaciji u drugoj igrici
void nacrtajLopticu() {
  fill(blue);
  ellipse(lopticax, lopticay, visinaLop, sirinaLop);
}

//micanje loptice određenom brzinom
void pomakniLopticu() {
  lopticax = lopticax + brzinax;
  lopticay = lopticay + brzinay;
}

/// detekcija pokreta, kreiranje plocica

//kreiranje dvije pločice s kojima se udara loptica
void nacrtajPlocicu() {
  fill(zuta);
  rect(lijevaL, lijevaV, debljina, visina);
  fill(bijela);
  rect(desnaD, desnaV, debljina, visina);
}

void pritisnutaTipka() {
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
void pomakniPlocicu() {
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
    udaracLopticeUZid.reproduciraj();
  } else if ( lopticax < 0 + sirinaLop/2)
  {
    udaracLopticeUZid.reproduciraj();
    osvjeziIgre();
    bodovi2 = bodovi2 + 1;
  }
  // gornja i donja strana
  if ( lopticay > height - visinaLop/2)
  {
    brzinay = -brzinay;
  } else if ( lopticay < 0 + visinaLop/2)
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

//provjeravamo je li loptica udarila o pločicu
void dodir() {
  if (lopticax - sirinaLop/2 < lijevaL + debljina && lopticay - visinaLop/2 < lijevaV + visina/2 && lopticay + visinaLop/2 > lijevaV - visina/2 ) {
    if (brzinax < 0) {
      udaracLopticeUPlocicu.reproduciraj();
      brzinax = -(brzinax-0.2);
    }
  } else if (lopticax + sirinaLop/2 > desnaD && lopticay - visinaLop/2 < desnaV + visina/2 && lopticay + visinaLop/2 > desnaV - visina/2 ) {
    if (brzinax > 0) {
      udaracLopticeUPlocicu.reproduciraj();
      brzinax = -(brzinax+0.2);
    }
  }
}
