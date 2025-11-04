void drawPrepareServingScreen() {
  background(oldMoneyBackground);

  fill(oldMoneyLight);
  rect(630, 0, 15, 1200); // Seperationslinje


  drawColorschemeSelection();
  drawServingSettings();
  drawBeginServingButton();
}

void drawServingSettings() {
  fill(oldMoneyLight);
  rect(width/2, 150, 630, 100);
  rect(width/2-10, 390, 70, 70);
  rect(width/2-10, 490, 70, 70);

  fill(#FFFFFF);
  rect(width/2+10, 160, 610, 80);
  rect(width/2-5, 395, 60, 60);
  rect(width/2-5, 495, 60, 60);

  fill(oldMoneyText);
  textAlign(CENTER, CENTER);
  textSize(56);
  text("Serveringsindstillinger", width/2+310, 200);
  text("Brug adgangskode", width/2+230, 420);
  text("Kun alkoholfrie drinks", width/2+160, 520);

  if (password) fill(0);
  else fill(255);
  rect(width/2, 400, 50, 50);

  // Detect click
  if (areaHover(width/2, 400, 60, 60)) {
    if (mousePressed && !mouseClicked) {
      password = !password;
      mouseClicked = true;
    }
    if (!mousePressed) {
      mouseClicked = false;
    }
  }

  if (nonAlkohol) fill(0);
  else fill(255);
  rect(width/2, 500, 50, 50);

  // Detect click
  if (areaHover(width/2, 500, 60, 60)) {
    if (mousePressed && !mouseClicked) {
      nonAlkohol = !nonAlkohol;
      mouseClicked = true;
    }
    if (!mousePressed) {
      mouseClicked = false;
    }
  }
}



void drawBeginServingButton() {
  noStroke();

  fill(149, 146, 88);
  if (areaHover(983, 1050, 500, 100)) {
    fill(#F0F0F0);
    if (mousePressed) {
      fill(#24F064);
    }
    if (mouseReleased) {
      switchToScreenServing();
    }
  }

  rect(983, 1050, 500, 100);

  fill(oldMoneyText);
  textAlign(CENTER, CENTER);
  textSize(56);
  text("Begynd servering", 1233, 1100);
}

void drawColorschemeSelection() {
  noStroke();

  fill(oldMoneyLight);
  rect(50, 150, 430, 100);

  fill(#FFFFFF);
  rect(60, 160, 410, 80);

  fill(oldMoneyText);
  textAlign(CENTER, CENTER);
  textSize(56);
  text("Farveskemaer", 265, 200);

  drawColorschemeSelectionScheme(50, 300, "Light mode", #FFFFFF, #D9D9D9, #000000);
  drawColorschemeSelectionScheme(50, 450, "Dark mode", #000000, #D9D9D9, #FFFFFF);
  drawColorschemeSelectionScheme(50, 600, "Pink mode", #FFE1FD, #865280, #000000);
  drawColorschemeSelectionScheme(50, 750, "Blue mode", #DAFFFE, #5175AE, #000000);
  drawColorschemeSelectionScheme(50, 900, "Yellow mode", #FBFFDA, #896446, #000000);
}

void drawColorschemeSelectionScheme(int topLeftX, int topLeftY, String name, int colorBackgroundScheme, int colorDarkScheme, int colorTextScheme) {
  noStroke();

  fill(oldMoneyLight);
  rect(topLeftX, topLeftY, 160, 100);

  fill(oldMoneyText);
  textAlign(LEFT, CENTER);
  textSize(36);
  text(name, topLeftX+180, topLeftY+50);

  fill(colorBackgroundScheme);
  rect(topLeftX+10, topLeftY+10, 47, 80);

  fill(colorDarkScheme);
  rect(topLeftX+57, topLeftY+10, 46, 80);

  fill(colorTextScheme);
  rect(topLeftX+103, topLeftY+10, 47, 80);

  if (buttonClicked(topLeftX, topLeftY, 160, 100)) {
    colorBackground = colorBackgroundScheme;
    colorDark = colorDarkScheme;
    colorText = colorTextScheme;
  }
}
