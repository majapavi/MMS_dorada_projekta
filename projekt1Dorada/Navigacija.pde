
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
