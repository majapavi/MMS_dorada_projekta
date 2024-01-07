

void prikaziPocetniZaslon() {
  background(pozadina);
  
  Text naslov0 = new Text( 330, 100, 60, "Igrice s lopticom", zuta );
  naslov0.ispisiText();
   
  // 1 IGRAČ
  jedanIgrac.nacrtajGumb();
  
  // 2 IGRAČA
  dvaIgraca.nacrtajGumb();
  
  // PRAVILA
  pravila.nacrtajGumb();

  // REGULIRAJ ZVUK
  if(music == 1){
    mute.nacrtajGumb();
  } else { 
    unmute.nacrtajGumb();
  }
  if(sound == 1){
    soundOff.nacrtajGumb();
  } else { 
    soundOn.nacrtajGumb();
  }
  
  // Postavke
  postavke.nacrtajGumb();
  
}

void ispisiPravila() {
    background(pozadina);
     
    Text naslov5a = new Text( 350, 45, 40, "Skupi loptice (1 igrač)", zuta );
    naslov5a.ispisiText();
    
    String pravilo1 = "U ovoj igrici, vi ste crvena loptica. Pomičući miša,\nmičete svoju lopticu. " + 
                      "Cilj je tom lopticom dotaknuti\nzelene loptice i tako skupiti što više bodova u što\nkraćem vremenu. " +  
                      "Pri doticanju zelene loptice - broj\nbodova, ali i broj plavih loptica se povećava.\n" + 
                      "Na početku imate 3 života. Doticanjem plavih loptica\ngubite život. Igra je gotova kada izgubite sve živote.\n" + 
                      "Ako dotaknete žutu lopticu, dobit ćete navedeni bonus,\na ako dotaknete ljubičastu dobit ćete navedenu kaznu.";
    Text tekst5a = new Text( 350, 225, 30, pravilo1, bijela );
    tekst5a.ispisiText();
    
    Text naslov5b = new Text( 350, 430, 40, "Pong (2 igrača)", zuta );
    naslov5b.ispisiText();
    
    String pravilo2 = "Cilj ove igrice je poslati protivniku \nlopticu tako da je on ne može vratiti. \nPobjednik je onaj igrač kojem to 5 puta \n" +
                      "pođe za rukom. Upravlja se tipkama\nW-S i strelicama GORE-DOLJE.";
    Text tekst5b = new Text( 350, 545, 30, pravilo2, bijela );
    tekst5b.ispisiText();
    
    nazad.nacrtajGumb();
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
