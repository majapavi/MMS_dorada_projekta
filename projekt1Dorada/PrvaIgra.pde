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
color blue = color(0, 0, 255), green = color(0, 255, 0), red = color(255, 0, 0), purple = color(128,0,128), yellow = color(255,255,0);
int powerUpCount = 0;
Loptica powerUp;
int start;
String[] pozitivniPowerUp = { "addExtraLife", "allGreen", "ExtraPoints"}; // two green, slow down blue ones
String[] negativniPowerUp = { "bigBlue", "speedUpBlueOnes"}; // speed up blue ones, negative points, missing(out of screen) green for short period(mean), 
String dodijeljenPowerUp;

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
   
      Text rez = new Text( 80, 40, 30, "Rezultat: " + rezultat, color(255, 255, 255));
      rez.ispisiText();

      Text zivoti = new Text(width - 120, 40, 30, "Broj zivota: " + brojZivota, color(255, 255, 255));
      zivoti.ispisiText();
      
      
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
            protiv[i].postaviNoveKoordinate(); // dotaknutu plavu lopticu udaljimo od crvene
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
      
     dodajPowerUp();
     
     prikaziPowerUp();     
     
     if (detektiranaKolizijaPowerUp()){
       // remove powerUp, 
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
