void dodajPowerUp() {
  if (rezultat > 0 && rezultat % 4 == 0 && powerUpCount == 0) {
    float rand = random(1,10);
    if (rand <= 3) {
      // negativni
      powerUp = napraviLopticuBoje(yellow); 
      dodijeljenPowerUp = negativniPowerUp[ int(random(negativniPowerUp.length)) ];
      
    } else {
      powerUp = napraviLopticuBoje(purple); 
      dodijeljenPowerUp = pozitivniPowerUp[ int(random(pozitivniPowerUp.length)) ];
      powerUpCount += 1; 
    }
  }
}

void prikaziPowerUp() {
    if (powerUpCount >= 1) {
      fill(powerUp.boja);
      ellipse(powerUp.x, powerUp.y, powerUp.radius, powerUp.radius);   
    }
}

boolean detektiranaKolizijaPowerUp() {
  if (powerUpCount >= 1) {
    if (dist(mouseX, mouseY, powerUp.x, powerUp.y) < powerUp.radius){
      print(dodijeljenPowerUp);      
      // trebam removeat.. 
      return true;
    }
  }
  return false;
}
