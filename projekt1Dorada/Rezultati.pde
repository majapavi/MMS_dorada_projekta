
// Ažurira rang listu nakon završetka prve igre.
void updateRangTable() {
  vrijemeKraja = millis();
  trajanjeIgre = vrijemeKraja - vrijemePocetka;
  //print(trajanjeIgre + "\n");
  int ukupniRezultat = rezultat + dodatniBodovi;
    
  int brojRedaka = rang.getRowCount();
  // Rang tablica bi već trebala biti sortirana silazno po broju bodova.
  if (brojRedaka < 10) {
    
    TableRow redak = rang.addRow();
    redak.setString("igrac", igrac);
    redak.setInt("rezultat", ukupniRezultat);
    redak.setInt("vrijeme", trajanjeIgre);

    rang.sortReverse(1);
    

    rangPlasiranog = 1;
    TableRow novi_redak;
    for (TableRow redak_temp : rang.rows())
    {
      if(redak_temp.getInt("rezultat") == ukupniRezultat && redak_temp.getInt("vrijeme") == trajanjeIgre)
        break;
      rangPlasiranog += 1;
    }

    
    dolazakNaRangListu.trigger();
    
    saveTable(rang, "data/rang.csv");
  }
  else
  {
    TableRow zadnjiRedak = rang.getRow(brojRedaka-1);
    if (zadnjiRedak.getInt("rezultat") < ukupniRezultat
      || (zadnjiRedak.getInt("rezultat") == ukupniRezultat && zadnjiRedak.getInt("vrijeme") > trajanjeIgre))
    {
      // Obriši zadnjeg.
      rang.removeRow(brojRedaka-1);
      // Dodaj novog.
      TableRow redak = rang.addRow();
      redak.setString("igrac", igrac);
      redak.setInt("rezultat", ukupniRezultat);  
      redak.setInt("vrijeme", trajanjeIgre);

      rang.sortReverse(1);
  
  
      rangPlasiranog = 1;
      TableRow novi_redak;
      for (TableRow redak_temp : rang.rows())
      {
        if(redak_temp.getInt("rezultat") == ukupniRezultat && redak_temp.getInt("vrijeme") == trajanjeIgre)
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
 
