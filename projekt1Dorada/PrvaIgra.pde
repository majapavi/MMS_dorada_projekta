//za prvu igricu
int brojZivota = 0;
int collisionCooldown = 0;
int collisionCooldownAllGreen = 0;
int radijus = 50;
int radijusPowerUp = 55;
int rezultat; // unedno i counter za broj protivnika
int dodatniBodovi = 0;
boolean odabranaPrvaIgra;
boolean kraj;
Loptica[] protiv;
Loptica dohvati;
int vrijemePocetka, vrijemeKraja, trajanjeIgre;
int trenutnoVrijeme, minute, sekunde, prosloVrijeme;
color blue = color(0, 0, 255), green = color(0, 255, 0), red = color(255, 0, 0), purple = color(128, 0, 128), yellow = color(255, 255, 0);
int powerUpCount = 0;
PowerUp powerUp;
int startAllGreen; // za mjerenje vremena 
String[] pozitivniPowerUp = {"addExtraLife", "allGreen", "ExtraPoints", "slowDownBlueOnes", "fewSmallBlue"}; // two green, few powerUps at the same time
String[] negativniPowerUp = {"speedUpBlueOnes", "fewBigBlue"}; // negative points, green missing(out of screen) for short period(mean),
String dodijeljenPowerUp;
boolean allGreen = false;
int trenutniAllGreen;
int pocetnoVrijemePrijePU;
int trenutnoVrijemeDoPU;
int startShake = 0;
int trenutniShake = 0;

String deklinacija(int ukupniRezultat) {
  String bodova = " bodova";
  if( ukupniRezultat%10 < 5 && ukupniRezultat/10 != 1 && ukupniRezultat%10 > 0){
    if(ukupniRezultat == 1 || ukupniRezultat%10 == 1 ){
      bodova = " bod.";
    } else {
      bodova = " boda.";
    }
  }
  return bodova;
}

void prijavaPrvaIgra() {
  background(pozadina);

  igra1_igrac.setVisible(true).setFocus(true);

  Text ime = new Text (350, 300, 70, "Upišite ime:", zuta);
  ime.ispisiText();

  // Gumb "Igraj!" s kojim započinje igra nakon upisa imena.
  igraj.nacrtajGumb();
  nazad.nacrtajGumb();

  if (igra1_igrac.getText().length() > 20) {
    Text duljinaUsername = new Text(350, 450, "Ime smije sadržavati najviše 20 znakova!");
    duljinaUsername.ispisiText();
  }
  
  postavke.nacrtajGumb();
}

void prikaziPrvuIgru() {
  {
    background(pozadina);

    int ukupniRez = rezultat + dodatniBodovi; // pridodat dodatne bodove "rucno" jer je var rezultat counter za broj protivnika

    Text rez = new Text( 80, 40, 30, "Rezultat: " + ukupniRez, bijela);
    rez.ispisiText();

    // ispis powerupsa
    if ( powerUp != null) {

      String imePowerUpa = powerUp.ime;

      if (imePowerUpa == "ExtraPoints") {
        Text power = new Text(80, 60, 30, powerUp.ime, powerUp.boja); // ispod rezultata
        power.ispisiText();
      } else if (imePowerUpa == "addExtraLife") {
        Text power = new Text(width - 120, 60, 30, powerUp.ime, powerUp.boja); // ispod broja zivota
        power.ispisiText();
      } else {
        Text power = new Text(width/2 - 20, 50, 30, powerUp.ime, powerUp.boja);  // na sredini
        power.ispisiText();
      }
    }

    Text zivoti = new Text(width - 120, 40, 30, "Broj života: " + brojZivota, bijela);
    zivoti.ispisiText();
    
    // ispis vremena igranja igrice    
    trenutnoVrijeme = millis() - vrijemePocetka;
    trajanjeIgre = trenutnoVrijeme + prosloVrijeme;
    
    sekunde = trajanjeIgre/1000;
    minute = sekunde/60;
    sekunde = sekunde - minute*60;
    
    Text vrijeme = pretvoriVrijeme(minute, sekunde);
    vrijeme.ispisiText();

    crtajLoptice();

    // dotakli smo plavu
    for (int i = 0; i<rezultat +1; i++) {
      if (dist(mouseX, mouseY, protiv[i].x, protiv[i].y) < protiv[i].radius-2 && collisionCooldown <=0 )
      {
        if (allGreen) {
          trenutniAllGreen = millis();
          promijeniUBoju(green);
          if(collisionCooldownAllGreen <= 0){
            if (trenutniAllGreen - startAllGreen <= 3000) {
              dodatniBodovi++;
            } else {
              allGreen = false; 
              promijeniUBoju(blue);
              delay(500);
            }
          }
        } else {
          startShake = millis();
          //delay(500); // freeze
          brojZivota -= 1;
          if (brojZivota > 0) {
            protiv[i].postaviNoveKoordinate(); // dotaknutu plavu lopticu udaljimo od crvene
          } else if (brojZivota == 0) {
            odabranaPrvaIgra = false;
            updateRangTable();
            prozor = 3;
            radijusPowerUp = 55;
            radijus = 50; // inace se broji od zadnje zapamcene vrijednosti
            removePowerUp();
          }
          collisionCooldown = 20;
        }
        collisionCooldownAllGreen = 15;

      }
    }

    // dotakli smo zelenu
    if (dist(mouseX, mouseY, dohvati.x, dohvati.y) < dohvati.radius)
    {
      rezultat++;
      if (allGreen) {
        protiv[rezultat] = napraviLopticuBoje(green);
      } else {
        protiv[rezultat] = napraviLopticu();
      }
      dohvati.postaviNoveKoordinate(); // td ne mijenja velicinu zelene i crvene loptice
    }

    if (detektiranaKolizijaPowerUp()) {
      aktivirajPowerUp();
      removePowerUp();
    }

    if (collisionCooldown > 0) {
      collisionCooldown--;
    }
    if (collisionCooldownAllGreen > 0) {
      collisionCooldownAllGreen--;
    }
  }
}

void prikaziKrajPrveIgre() {
  background(pozadina);

  int ukupniRezultat = rezultat + dodatniBodovi;
  
  Text rez = new Text(350, 100, 60, "Skupili ste " + ukupniRezultat + deklinacija(ukupniRezultat), zuta);
  rez.ispisiText();

  // Prikaži rang listu.
  if (rangPlasiranog != -1 && rezultat != 0)
  {
    Text rang = new Text(350, 170, 30, "Bravo, " + igrac +"!\nOsvojili ste " + rangPlasiranog + ". mjesto na rang listi! :D", zuta);
    rang.ispisiText();
  } else {
    Text tekst = new Text(350, 170, 30, "Žao nam je, niste plasirani na rang listu :(", zuta);
    tekst.ispisiText();
  }

  Text rangLista = new Text(350, 350, 50, "Rang lista", bijela);
  rangLista.ispisiText();
  prikaziRangListu(370);

  izbornik.nacrtajGumb(50, 220);
  ponovno.nacrtajGumb(250, 220);
  postavke.nacrtajGumb(500, 220);
}

void crtajLoptice() { // crtanje loptica odvojeno od detekcije kolizije s lopticama

  //crvena loptica koja je uvijek tamo gdje je miš
  dohvati.shakeIfActive();

  //zelena loptica koju trebamo uhvatiti
  fill(dohvati.boja);
  ellipse(dohvati.x, dohvati.y, dohvati.radius, dohvati.radius);

  dohvati.update();

  //plave loptice koje ne smijemo udariti
  for (int i = 0; i<rezultat +1; i++)
  {
    protiv[i].update();
    fill(protiv[i].boja);
    ellipse(protiv[i].x, protiv[i].y, protiv[i].radius, protiv[i].radius);
  }

  // powerUps
  trenutnoVrijemeDoPU = millis();
  dodajPowerUp();
  prikaziPowerUp();
}
