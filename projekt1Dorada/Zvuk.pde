
// Dodavanje varijabli za zvuk
Minim minim;
AudioPlayer pozadinskaMuzika;

//Zvukovi za prvu igru
Zvuk dolazakNaRangListu;
Zvuk krajIgre;

// Zvukovi za drugu igru
Zvuk udaracLopticeUZid;
Zvuk udaracLopticeUPlocicu;

int music = 1;
int sound = 1;

class Zvuk {
  AudioSample zvuk;

  Zvuk( String putanja ) {
    zvuk = minim.loadSample(putanja);
  }

  // Reproduciraj zvuk ako je dozvoljeno od korisnika
  void reproduciraj() {
    if ( sound == 1)
      zvuk.trigger();
  }
}

void setupZvuka() {
  // Dodavanje pozadinske glazbe
  minim = new Minim(this);
  pozadinskaMuzika = minim.loadFile("Zvuk/pozadinskaMuzika.mp3");

  // Postavljanje zvukovnih efekata
  udaracLopticeUZid = new Zvuk("Zvuk/udaracLopticeUZid.mp3");
  udaracLopticeUPlocicu = new Zvuk("Zvuk/udaracLopticeUPlocicu.wav");
  dolazakNaRangListu = new Zvuk("Zvuk/dolazakNaRangListu.wav");
  krajIgre = new Zvuk("Zvuk/krajIgre.wav");

  // Pokreće pozadinsku muziku
  pozadinskaMuzika.loop();
}
