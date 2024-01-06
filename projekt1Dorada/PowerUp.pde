
class PowerUp extends Loptica {
  String ime; // tako da ne treba globalna vrijednost imena dodijeljenogPoweUpa
  float a;

  PowerUp(float x_, float y_, float brzinax_, float brzinay_, float radius_, color boja_, String ime_) {

    super(x_, y_, brzinax_, brzinay_, radius_, boja_);
    ime = ime_;
    a = 0.0;
  }

  void update() {
    a = a + 0.04;
    y += brzinay;

    // reflektiranje ako od x
    if (x <= 0 || x >= width) {
      brzinax = -brzinax;
    }
    x = x  + sin(a);
  }
  void unistiAkoPresaoScreen() {
    if (y >= height) {
      removePowerUp();
    }
  }
}

PowerUp napraviPowerUp(color boja, String ime)
{
  int x, y, brzinay;
  do
  {
    x = (int) random(10, width-10);
    y = (int) random(-5, 0);
  }
  while (dist(mouseX, mouseY, x, y) < radijus*2 + 50);
  brzinay = (int) random(1.5, 6);
  return new PowerUp(x, y, 0, brzinay, radijus, boja, ime); // defaultno plava
}

void dodajPowerUp() {

  if (rezultat > 0 && vrijeme() && powerUpCount == 0 && collisionCooldown <=0) {
    powerUpCount = 1;
    
    float random = random(1, 11);
    if (random < 4) {
      dodijeljenPowerUp = negativniPowerUp[ int(random(negativniPowerUp.length)) ];
      powerUp = napraviPowerUp(purple, dodijeljenPowerUp);
    } else if (random >= 4) {
      dodijeljenPowerUp = pozitivniPowerUp[ int(random(pozitivniPowerUp.length)) ];
      powerUp = napraviPowerUp(yellow, dodijeljenPowerUp);
    }
  } 
}

boolean vrijeme() {
  //print(trenutnoVrijemeDoPU - pocetnoVrijemePrijePU + "\n");
  return (trenutnoVrijemeDoPU - pocetnoVrijemePrijePU >= 4500); // namjestit koliko svakih sekundi zelimo da dode novi powerUPs
}

void prikaziPowerUp() {
  if (powerUpCount >= 1 && powerUp != null ) {
    powerUp.update();
    fill(powerUp.boja);
    ellipse(powerUp.x, powerUp.y, powerUp.radius, powerUp.radius);

    powerUp.unistiAkoPresaoScreen(); // provjera ide ovdje, inace ude u stanje natjecanja ako npr. ide removeat u update i sl.
    // zato sto se prvo updatea pa onda crta
  }
}

boolean detektiranaKolizijaPowerUp() {
  if (powerUpCount >= 1  && powerUp != null) {
    if (dist(mouseX, mouseY, powerUp.x, powerUp.y) < powerUp.radius) {
      powerUpCount = 0;
      return true;
    }
  }
  return false;
}

void removePowerUp() {
  powerUpCount = 0;
  powerUp = null;
  pocetnoVrijemePrijePU = millis();
}


void aktivirajPowerUp() {
  if (powerUp != null) {
    if (powerUp.ime.equals("addExtraLife")) {
      brojZivota += 1;
    } else if (powerUp.ime.equals("ExtraPoints")) {
      dodatniBodovi += 3;
    } else if (powerUp.ime.equals("slowDownBlueOnes")) {
      usporiPlaveLoptice();
    } else if (powerUp.ime.equals("speedUpBlueOnes")) {
      ubrzajPlaveLoptice();
    } else if (powerUp.ime.equals("allGreen")) {
      allGreen = true;
      startAllGreen = millis();
      promijeniUBoju(green);
    } else if (powerUp.ime.equals("fewBigBlue")) {
      povecajPlaveLoptice();
    } else if (powerUp.ime.equals("fewSmallBlue")) {
      smanjiPlaveLoptice();
    }

    // resetiraj powerUp
    dodijeljenPowerUp = "";
  }
}
// implementacija powerupova
void ubrzajPlaveLoptice() {
  // postotak trenutno aktivnih loptica dobivaju ubrzanje 1,5 puta za obje koordinate x, y
  int[] odabraneLoptice = izvuceneLoptice(0.15);
  for (int i = 0; i < odabraneLoptice.length; i++) {
    int index = odabraneLoptice[i];

    if (protiv[index] != null) {
      protiv[index].updateBrzinu(1.5, 1.5); // po postotku, mnozi se
    }
  }
}

void usporiPlaveLoptice() {
  // postotak trenutno aktivnih loptica dobivaju ubrzanje 1,5 puta za obje koordinate x, y
  int[] odabraneLoptice = izvuceneLoptice(0.15);
  for (int i = 0; i < odabraneLoptice.length; i++) {
    int index = odabraneLoptice[i];

    if (protiv[index] != null) {
      protiv[index].updateBrzinu(0.75, 0.75); // po postotku, mnozi se sa starom
    }
  }
}

void povecajPlaveLoptice() {
  int[] odabraneLoptice = izvuceneLoptice(0.15);
  for (int i = 0; i < odabraneLoptice.length; i++) {
    int index = odabraneLoptice[i];

    if (protiv[index] != null) {
      protiv[index].updateRadius(radijusPowerUp);
      radijusPowerUp *= 1.2;
    }
  }
}

void smanjiPlaveLoptice() {
  int[] odabraneLoptice = izvuceneLoptice(0.15);
  for (int i = 0; i < odabraneLoptice.length; i++) {
    int index = odabraneLoptice[i];

    if (protiv[index] != null) {
      //protiv[index].updateRadius(protiv[index].radius - 20); // drektno promijenit radius ILI
      protiv[index].updateRadius(radijusPowerUp);
      radijusPowerUp /= 1.2;
    }
  }
}

int[] izvuceneLoptice(float decimPostotak) {
  int num = floor(decimPostotak*protiv.length);
  int[] listaIndexa = new int[num];

  for (int i = 0; i < num; i++) {
    int randIndex = 0;
    do {
      randIndex = int(random(protiv.length));
    } while (contain(listaIndexa, randIndex));

    listaIndexa[i] = randIndex;
  }

  return listaIndexa;
}

// pomocne fje
boolean contain(int[] array, int value) {
  for (int element : array) {
    if (element == value) {
      return true;
    }
  }
  return false;
}
boolean containString(String[] array, String value) {
  for (String element : array) {
    if (element == value) {
      return true;
    }
  }
  return false;
}

void promijeniUBoju(color boja) {
  for (int i = 0; i < protiv.length; i++) {
    if (protiv[i] != null) {
      protiv[i].promijeniBojuU(boja);
    }
  }
}
