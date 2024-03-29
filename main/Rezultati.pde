/// globalne funkcije za ažuriranje i prikaz rezultata

// Ažurira rang listu nakon završetka prve igre.
void updateRangTable() {
  vrijemeKraja = millis();
  trajanjeIgre = vrijemeKraja - vrijemePocetka + prosloVrijeme;
  prosloVrijeme = 0;
  int ukupniRezultat = rezultat + dodatniBodovi;
  int ukupniRezultatPlusVrijeme = ukupniRezultat*10000000 + (10000000 - trajanjeIgre);

  int brojRedaka = rang.getRowCount();
  // Rang tablica bi već trebala biti sortirana silazno po broju bodova i vremenu igranja igre.
  if (brojRedaka < 10) {

    TableRow redak = rang.addRow();
    redak.setString("igrac", igrac);
    redak.setInt("rezultat", ukupniRezultat);
    redak.setInt("vrijeme", trajanjeIgre);
    redak.setInt("sveukupno", ukupniRezultatPlusVrijeme);

    rang.sortReverse(3);


    rangPlasiranog = 1;
    for (TableRow redak_temp : rang.rows())
    {
      if ( redak_temp.getInt("sveukupno") == ukupniRezultatPlusVrijeme)
        break;
      rangPlasiranog += 1;
    }


    dolazakNaRangListu.reproduciraj();

    saveTable(rang, "data/rang.csv");
  } else
  {
    TableRow zadnjiRedak = rang.getRow(brojRedaka-1);
    if (zadnjiRedak.getInt("sveukupno") < ukupniRezultatPlusVrijeme
      || (zadnjiRedak.getInt("sveukupno") == ukupniRezultatPlusVrijeme) )
    {
      // Obriši zadnjeg.
      rang.removeRow(brojRedaka-1);
      // Dodaj novog.
      TableRow redak = rang.addRow();
      redak.setString("igrac", igrac);
      redak.setInt("rezultat", ukupniRezultat);
      redak.setInt("vrijeme", trajanjeIgre);
      redak.setInt("sveukupno", ukupniRezultatPlusVrijeme);

      rang.sortReverse(3);


      rangPlasiranog = 1;
      for (TableRow redak_temp : rang.rows())
      {
        if ( redak_temp.getInt("sveukupno") == ukupniRezultatPlusVrijeme)
          break;
        rangPlasiranog += 1;
      }


      dolazakNaRangListu.reproduciraj();
      saveTable(rang, "data/rang.csv");
    }
    // U protivnom, igrač se nije plasirao i ne radimo ništa.
    else
    {
      rangPlasiranog = -1;
      krajIgre.reproduciraj();
    }
  }
}

void prikaziRangListu(float startY) {
  int i = 1;
  textSize(30);

  for (TableRow row : rang.rows()) {
    textAlign(RIGHT);
    fill(zuta);
    text(i + ".\b", 100, startY+(40*i));
    textAlign(LEFT);
    text(row.getString("igrac"), 105, startY+(40*i) );
    text(row.getInt("rezultat") + deklinacija(row.getInt("rezultat")), 300, startY+(40*i));
    text("vrijeme: " + pretvoriVrijeme( row.getInt("vrijeme") ), 500, startY+(40*i));
    ++i;
  }
}
