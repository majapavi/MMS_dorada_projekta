
//klasa koju implementiramo za loptice u prvoj igrici
class Loptica
{
  float x, y, brzinax, brzinay, radius;
  color boja;

  Loptica (float x_, float y_, float brzinax_, float brzinay_, float radius_, color boja_)
  {
    x = x_;
    y = y_;
    brzinax = brzinax_;
    brzinay = brzinay_;
    radius = radius_;
    boja = boja_;
  }

  void update()
  {
    x += brzinax;
    y += brzinay;
    if (x <= (radius/2) || x >= width-(radius/2))
      brzinax = -brzinax;

    if (y <= 50 + (radius/2) || y >= height-(radius/2))
      brzinay = -brzinay;
  }

  void promijeniBojuU(color novaBoja) {
    boja = novaBoja;
  }

  // kada se uhvati zelena loptica, postavi ju na neko drugo random mjesto
  void postaviNoveKoordinate() {
    float x, y;
    do
    {
      x = random((radijus/2), width-(radijus/2) );
      y = random(50 + (radijus/2), height-(radijus/2) );
    }
    while (dist(mouseX, mouseY, x, y) < radijus*2 + this.radius);
    this.x = x;
    this.y = y;
  }

  void updateRadius(float r) {
    if ( r >= 20 || r <= 150 ) {
      radius = r;
    }
  }

  void updateBrzinu(float decimPostotakX, float decimPostotakY) {
    if (brzinax <= 5 && brzinay <= 5 && brzinax >= 1 && brzinay >=1) {
      brzinax *= decimPostotakX;
      brzinay *= decimPostotakY;
    }
  }

  // zatresi crvenu lopticu prilikom sudara sa plavom
  void shakeIfActive() {
    trenutniShake = millis();
    if (trenutniShake - startShake <= 1000) {
      trenutniShake = millis();
      fill(red);
      ellipse(mouseX + random(-10, 10), mouseY + random(-10, 10), dohvati.radius, dohvati.radius);
    } else {

      fill(red);
      ellipse(mouseX, mouseY, dohvati.radius, dohvati.radius);
    }
  }
}

//kreiranje loptice na bilo kojoj lokaciji s random brzinom
Loptica napraviLopticu()
{
  float x, y, brzinax, brzinay;

  do
  {
    x = random((radijus/2), width-(radijus/2) );
    y = random( 50 + (radijus/2), height-(radijus/2) );
  }
  while (dist(mouseX, mouseY, x, y) < radijus*2 + 50);
  brzinax = random(0.6, 5);
  brzinay = random(0.6, 5);
  return new Loptica(x, y, brzinax, brzinay, radijus, blue); // defaultno plava
}

//kreiranje loptice određene boje
Loptica napraviLopticuBoje(color boja)
{
  float x, y, brzinax, brzinay;

  do
  {
    x = random((radijus/2), width-(radijus/2) );
    y = random( 50 + (radijus/2), height-(radijus/2) );
  }
  while (dist(mouseX, mouseY, x, y) < radijus*2 + 50);
  brzinax = random(0.6, 5);
  brzinay = random(0.6, 5);
  return new Loptica(x, y, brzinax, brzinay, radijus, boja);
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
