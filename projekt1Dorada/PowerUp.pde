void dodajPowerUp() {
  if (rezultat > 0 && rezultat % 4 == 0 && powerUpCount == 0) {
    float rand = random(1, 10);
    if (rand <= 3) {
      // negativni
      powerUp = napraviLopticuBoje(yellow);
      dodijeljenPowerUp = negativniPowerUp[ int(random(negativniPowerUp.length)) ];
    } else {
      powerUp = napraviLopticuBoje(purple);
      dodijeljenPowerUp = pozitivniPowerUp[ int(random(pozitivniPowerUp.length)) ];
      powerUpCount += 1;
    }
  }
}

void prikaziPowerUp() {
  if (powerUpCount >= 1) {
    fill(powerUp.boja);
    ellipse(powerUp.x, powerUp.y, powerUp.radius, powerUp.radius);
  }
}

boolean detektiranaKolizijaPowerUp() {
  if (powerUpCount >= 1) {
    if (dist(mouseX, mouseY, powerUp.x, powerUp.y) < powerUp.radius) {
      print(dodijeljenPowerUp);
      // ukloni powerup
      powerUpCount = 0;
      return true;
    }
  }
  return false;
}

void aktivirajPowerUp() {
  if (dodijeljenPowerUp.equals("addExtraLife")) {
    brojZivota += 1;
  } else if (dodijeljenPowerUp.equals("ExtraPoints")) {
    dodatniBodovi += 3;
  } else if (dodijeljenPowerUp.equals("slowDownBlueOnes")) {
    usporiPlaveLoptice();
  } else if (dodijeljenPowerUp.equals("speedUpBlueOnes")) {
    ubrzajPlaveLoptice();
  } else if (dodijeljenPowerUp.equals("allGreen")) {
    // treba mi vremenska komponenta..
  } else if (dodijeljenPowerUp.equals("fewBigBlue")) {
    povecajPlaveLoptice();
  } else if (dodijeljenPowerUp.equals("fewSmallBlue")) {
    smanjiPlaveLoptice();
  }

  // resetiraj powerUp
  dodijeljenPowerUp = "";
}


void ubrzajPlaveLoptice() {
  // postotak trenutno aktivnih loptica dobivaju ubrzanje 1,5 puta za obje koordinate x, y
  int[] odabraneLoptice = izvuceneLoptice(0.15);
  for (int i = 0; i < odabraneLoptice.length; i++) {
    int index = odabraneLoptice[i];

    if (protiv[index] != null) {
      protiv[index].updateBrzinu(1.5, 1.5); // po postotku
    }
  }
}

void usporiPlaveLoptice() {
  // postotak trenutno aktivnih loptica dobivaju ubrzanje 1,5 puta za obje koordinate x, y
  int[] odabraneLoptice = izvuceneLoptice(0.15);
  for (int i = 0; i < odabraneLoptice.length; i++) {
    int index = odabraneLoptice[i];

    if (protiv[index] != null) {
      protiv[index].updateBrzinu(0.75, 0.75); // po postotku
    }
  }
}

void povecajPlaveLoptice() {
  int[] odabraneLoptice = izvuceneLoptice(0.15);
  for (int i = 0; i < odabraneLoptice.length; i++) {
    int index = odabraneLoptice[i];

    if (protiv[index] != null) {
      protiv[index].updateRadius(radijusPowerUp); 
      radijusPowerUp += 1.5;
    }
  }
}

void smanjiPlaveLoptice() {
  int[] odabraneLoptice = izvuceneLoptice(0.15);
  for (int i = 0; i < odabraneLoptice.length; i++) {
    int index = odabraneLoptice[i];

    if (protiv[index] != null) {
      protiv[index].updateRadius(protiv[index].radius); // samo njihov trenutni radijus, bez smanjenja radijusa opcenito
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

boolean contain(int[] array, int value) {
  for (int element : array) {
    if (element == value) {
      return true;
    }
  }
  return false;
}
