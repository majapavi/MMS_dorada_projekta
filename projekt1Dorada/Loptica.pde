
//klasa koju implementiramo za loptice u prvoj igrici
class Loptica
{
  float x, y, brzinax, brzinay, radius;
  color boja;

  Loptica (int x_, int y_, int brzinax_, int brzinay_, int radius_, color boja_)
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
    if (x <= 0 || x >= width)
      brzinax = -brzinax;

    if (y <= 0 || y >= width)
      brzinay = -brzinay;
  }

  void postaviNoveKoordinate() {
    int x, y;
    do
    {
      x = (int) random(width);
      y = (int) random(height);
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
    radius = r;
  }
}

//kreiranje loptice na bilo kojoj lokaciji s random brzinom
Loptica napraviLopticuBoje(color boja)
{
  int x, y, brzinax, brzinay;
  radijus += 1;
  do
  {
    x = (int) random(width);
    y = (int) random(height);
  }
  while (dist(mouseX, mouseY, x, y) < radijus*2 + 50);
  brzinax = (int) random(5);
  brzinay = (int) random(5);
  return new Loptica(x, y, brzinax, brzinay, radijus, boja);
}

Loptica napraviLopticu()
{
  int x, y, brzinax, brzinay;
  radijus += 1;
  do
  {
    x = (int) random(width);
    y = (int) random(height);
  }
  while (dist(mouseX, mouseY, x, y) < radijus*2 + 50);
  brzinax = (int) random(5);
  brzinay = (int) random(5);
  return new Loptica(x, y, brzinax, brzinay, radijus, blue); // defaultno plava
}

//napravi lopticu na početnoj lokaciji u drugoj igrici
void nacrtajLopticu() {
  fill(blue);
  ellipse(lopticax, lopticay, visinaLop, sirinaLop);
}

//micanje lopcite određenom brzinom
void pomakniLopticu() {
  lopticax = lopticax + brzinax;
  lopticay = lopticay + brzinay;
}
