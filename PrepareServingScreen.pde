void drawPrepareServingScreen() {
  background(oldMoneyBackground);

  fill(oldMoneyLight);
  rect(630, 0, 15, 1200); // Seperationslinje


  drawColorschemeSelection();
  drawServingSettings();
  drawBeginServingButton();

  image(oldMoneyKnap, 1850, 62);

  //tilbage knappen
  if (mouseReleased &&
    mouseX >= 1850 && mouseX <= 1950 &&
    mouseY >= 40 && mouseY <= 114) {
    switchToScreenMainMenu();
  }
}

void drawServingSettings() {
  fill(oldMoneyLight);
  rect(width/2, 150, 630, 100);
  rect(width/2-10, 290, 70, 70);
  rect(width/2-10, 390, 70, 70);

  fill(#FFFFFF);
  rect(width/2+10, 160, 610, 80);
  rect(width/2-5, 295, 60, 60);
  rect(width/2-5, 395, 60, 60);

  fill(oldMoneyText);
  textAlign(CENTER, CENTER);
  textSize(56);
  text("Serveringsindstillinger", width/2+310, 200);
  text("Adgangskode", width/2+230, 320);
  text("Alkohol", width/2+160, 420);

  if (savedPassword.equals("")){ 
    fill(255);
    password = false;
  }
  else fill(0);
  rect(width/2, 300, 50, 50);

  if (areaHover(width/2, 300, 60, 60)) {
    if (mousePressed && !mouseClicked) {
      passwordEntering = true;
      enteredPassword = "";
      mouseClicked = true;
    }
    if (!mousePressed) mouseClicked = false;
  }

  if (nonAlkohol) fill(0);
  else fill(255);
  rect(width/2, 400, 50, 50);

  if (areaHover(width/2, 400, 60, 60)) {
    if (mousePressed && !mouseClicked) {
      nonAlkohol = !nonAlkohol;
      mouseClicked = true;
    }
    if (!mousePressed) mouseClicked = false;
  }

  if (passwordEntering) {
    int LeftX = width/2;
    int LeftY = 500;

    fill(oldMoneyLight);
    rect(LeftX, LeftY, 400, 550, 20);
    fill(oldMoneyText);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Indtast adgangskode", LeftX+200, LeftY + 40);

    fill(255);
    rect(LeftX + 50, LeftY + 70, 300, 50, 10);
    fill(0);
    text("*".repeat(enteredPassword.length()), LeftX+200, LeftY + 95);

    int num = 1;
    for (int r = 0; r < 3; r++) {
      for (int c = 0; c < 3; c++) {
        if (areaHover(LeftX+50 + c*100, LeftY + 140 + r*100, 80, 80)) {
          if (mousePressed && !mouseClicked) {
            enteredPassword += str(num);
            mouseClicked = true;
          }
          if (!mousePressed) mouseClicked = false;
        }
        fill(255);
        rect(LeftX + 50 + c*100, LeftY + 140 + r*100, 80, 80, 15);
        fill(0);
        textSize(36);
        textAlign(CENTER, CENTER);
        text(str(num), LeftX + 50 + c*100 + 40, LeftY + 140 + r*100 + 40);
        num++;
      }
    }

    if (areaHover(LeftX + 150, LeftY + 440, 80, 80)) {
      if (mousePressed && !mouseClicked) {
        enteredPassword += "0";
        mouseClicked = true;
      }
      if (!mousePressed) mouseClicked = false;
    }
    fill(255);
    rect(LeftX + 150, LeftY + 440, 80, 80, 15);
    fill(0);
    text("0", LeftX + 150 + 40, LeftY + 440 + 40);

    if (areaHover(LeftX + 50, LeftY + 440, 80, 80)) {
      if (mousePressed && !mouseClicked) {
        if (enteredPassword.length() > 0) enteredPassword = enteredPassword.substring(0, enteredPassword.length()-1);
        mouseClicked = true;
      }
      if (!mousePressed) mouseClicked = false;
    }
    fill(200, 50, 50);
    rect(LeftX + 50, LeftY + 440, 80, 80, 15);
    fill(255);
    text("DEL", LeftX + 50 + 40, LeftY + 440 + 40);

    if (areaHover(LeftX + 250, LeftY + 440, 80, 80)) {
      if (mousePressed && !mouseClicked) {
        savedPassword = enteredPassword;
        passwordEntering = false;
        mouseClicked = true;
        password = true;
        println(savedPassword);
      }
      if (!mousePressed) mouseClicked = false;
    }
    fill(149, 146, 88);
    rect(LeftX + 250, LeftY + 440, 80, 80, 15);
    fill(0);
    text("OK", LeftX + 250 + 40, LeftY + 440 + 40);
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
    oldMoneyBackground = colorBackgroundScheme;
    oldMoneyLight = colorDarkScheme;
    oldMoneyText = colorTextScheme;
  }
}
