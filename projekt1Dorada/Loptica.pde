
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

    if (y <= (radius/2) || y >= height-(radius/2))
      brzinay = -brzinay;
  }
  
  void promijeniBojuU(color novaBoja) {
    boja = novaBoja;
  }

  void postaviNoveKoordinate() {
    float x, y;
    do
    {
      x = random((radijus/2), width-(radijus/2) );
      y = random((radijus/2), height-(radijus/2) );
    }
    while (dist(mouseX, mouseY, x, y) < radijus*2 + this.radius);
    this.x = x;
    this.y = y;
  }

  // za shake loptice (ako uspije)
  void pomakniKoordinateZa(float x_, float y_) {
    x += x_;
    y += y_;
  }
  
  void updateRadius(float r) {
    if ( r >= 20 || r <= 150 ) {
      radius = r;
    }
  }
 
  void updateBrzinu(float decimPostotakX, float decimPostotakY){
    if (brzinax <= 5 && brzinay <= 5 && brzinax >= 1 && brzinay >=1){
      brzinax *= decimPostotakX;
      brzinay *= decimPostotakY;
    }
  }
}

//kreiranje loptice na bilo kojoj lokaciji s random brzinom
Loptica napraviLopticuBoje(color boja)
{
  float x, y, brzinax, brzinay;
  //radijus += 1;
  do
  {
    x = random((radijus/2), width-(radijus/2) );
    y = random((radijus/2), height-(radijus/2) );
  }
  while (dist(mouseX, mouseY, x, y) < radijus*2 + 50);
  brzinax = random(0.6,5);
  brzinay = random(0.6,5);
  return new Loptica(x, y, brzinax, brzinay, radijus, boja);
}

Loptica napraviLopticu()
{
  float x, y, brzinax, brzinay;
  //radijus += 1;
  do
  {
    x = random((radijus/2), width-(radijus/2) );
    y = random((radijus/2), height-(radijus/2) );
  }
  while (dist(mouseX, mouseY, x, y) < radijus*2 + 50);
  brzinax = random(0.6,5);
  brzinay = random(0.6,5);
  return new Loptica(x, y, brzinax, brzinay, radijus, blue); // defaultno plava
}
