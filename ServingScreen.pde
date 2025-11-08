int colorBackground = #BBA591;
int colorDark = #FAECC3;
int colorText = #000000;

Drink selectedDrink;

ArrayList<Drink> possibleDrinksTemp;

void drawServingScreen() {
  background(colorBackground);

  if (selectedDrink == null) {
    possibleDrinksTemp = getPossibleDrinks();
    if (possibleDrinksTemp.size() > 0) {
      selectedDrink = possibleDrinksTemp.get(0);
    }
  }

  drawSelectedDrinkPart();

  fill(colorDark);
  rect(1090, 0, 10, 1200);

  drawDrinkSelectionPart();
}

void drawSelectedDrinkPart() {
  noStroke();

  if (selectedDrink == null) {
    fill(colorText);
    textAlign(CENTER, CENTER);
    textSize(100);
    text("Ingen mulige drinks", 545, 250);
    textSize(40);
    text("Prøv at connecte nogle flasker i virkeligheden,\nog sørg for at de samme flasker er connectede i programmet.\nFlasker kan tilføjes under flaske-skærmen, som kan tilgås\nfra \"Flasker\" knappen i main menu.", 545, 500);
    return;
  }


  fill(colorDark);
  rect(50, 50, 450, 450);
  selectedDrink.showIcon(275, 275, 450, 450);

  fill(colorText);
  textAlign(LEFT, BOTTOM);
  textSize(80);
  text(selectedDrink.name, 550, 250);

  fill(colorDark);
  rect(550, 248, 490, 4);//Linje til at seperere navn og ingredienser

  fill(colorText);
  textAlign(LEFT, TOP);
  textSize(56);
  text("Ingredienser:", 550, 272);
  textAlign(LEFT, CENTER);
  textSize(36);
  for (int i = 0; i < selectedDrink.usedIngredients.size(); i++) {
    float ingredientCenterY = 347+(i*35);
    text(selectedDrink.usedIngredients.get(i).amount + "x " + selectedDrink.usedIngredients.get(i).bottleName, 570, ingredientCenterY);
    circle(560, ingredientCenterY, 10);
  }

  fill(colorText);
  textAlign(LEFT, TOP);
  textSize(56);
  text("Information", 50, 550);
  textSize(36);
  text(selectedDrink.getFormattedDescription(18, 24), 50, 625);

  fill(colorText);
  textAlign(CENTER, CENTER);
  textSize(36);
  String volPercent = nf(selectedDrink.getAlcoholPercent()*100);
  text("Samlet alkohol vol%: " + volPercent + "%", 795, 1000);

  fill(colorDark);
  if (areaHover(550, 1025, 490, 125)) {
    fill(colorDark+#101010);
    if (mousePressed) {
      fill(colorDark-#101010);
    }
    if (mouseReleased) {
      sendDrinkCommand(selectedDrink);
    }
  }
  rect(550, 1025, 490, 125);

  fill(colorText);
  textAlign(CENTER, CENTER);
  textSize(64);
  text("Begynd servering", 795, 1087.5);
}

void sendDrinkCommand(Drink drink) {
  String request = "http://"+ip+"/STRING?";

  boolean isFirst = true;
  for (Ingredient ingredient : drink.usedIngredients) {
    if (isFirst) {
      request += "M" + str(getConnectedBottleIndex(ingredient.bottleName)) + "=" + ingredient.amount;
    } else {
      request += "&M" + str(getConnectedBottleIndex(ingredient.bottleName)) + "=" + ingredient.amount;
    }
    isFirst = false;
  }

  String[] feedback = loadStrings(request);
}

void drawDrinkSelectionPart() {
  ArrayList<Drink> possibleDrinkChoices = removeNonSearchedDrink(getPossibleDrinks());
  for (int i = 0; i < possibleDrinkChoices.size(); i++) {
    drawDrinkSelectionButton(1150+((i%2)*440), 150+((i/2)*440) - getScrollViewOffset(), 280, 280, possibleDrinkChoices.get(i));
  }

  fill(colorDark);
  rect(1150, 0, 720, 100);

  searchBar(1160, 10, 509, 80);

  image(oldMoneyKnap, 1800, 55);

  imageMode(CENTER);
  image(filterIcon, 1709, 50, 80, 80);
  if (areaHover(1669, 10, 80, 80) && mouseReleased) {
    showFilterCurrently = !showFilterCurrently;
  }
  if (showFilterCurrently) {
    showFilter(1709, 120);
  }

  float bottomYOfBottomBottle = 150+(((possibleDrinkChoices.size()-1)/2)*440);
  updateScrollbarAreaAndView(150, int(bottomYOfBottomBottle+280+50), 1050);
  drawScrollbar(width, 125, 20, false);

  if (passwordCheckMode) {
    int LeftX = width/2-200;
    int LeftY =height/2-275;

     fill(colorBackground,220);
    rect(0,0,width,height);
    
    if (doShake) {
      shake += 10 * shakeDirection;
      shakeDirection *= -1;
      shakeTimer--;
      if (shakeTimer <= 0) {
        doShake = false;
        shake = 0;
      }
      adgangskodeTekst = "Forkert Adgangskode";
      passwordIncorrectTextColor = #E00E0E;
    }


    fill(colorDark);
    rect(LeftX, LeftY, 400, 550, 20);
    fill(passwordIncorrectTextColor);
    textSize(32);
    textAlign(CENTER, CENTER);
    text(adgangskodeTekst, LeftX + 200, LeftY + 40);
    fill(colorText);

    fill(255);
    rect(LeftX + 50 + shake, LeftY + 70, 300, 50, 10);
    fill(0);
    text("*".repeat(attemptedPassword.length()), LeftX + 200, LeftY + 95);

    int num = 1;
    for (int r = 0; r < 3; r++) {
      for (int c = 0; c < 3; c++) {
        if (areaHover(LeftX + 50 + c * 100, LeftY + 140 + r * 100, 80, 80)) {
          if (mousePressed && !mouseClicked) {
            attemptedPassword += str(num);
            mouseClicked = true;
          }
          if (!mousePressed) mouseClicked = false;
        }
        fill(255);
        rect(LeftX + 50 + c * 100, LeftY + 140 + r * 100, 80, 80, 15);
        fill(0);
        textSize(36);
        textAlign(CENTER, CENTER);
        text(str(num), LeftX + 50 + c * 100 + 40, LeftY + 140 + r * 100 + 40);
        num++;
      }
    }

    // 0-knap
    if (areaHover(LeftX + 150, LeftY + 440, 80, 80)) {
      if (mousePressed && !mouseClicked) {
        attemptedPassword += "0";
        mouseClicked = true;
      }
      if (!mousePressed) mouseClicked = false;
    }
    
    fill(255);
    rect(LeftX + 150, LeftY + 440, 80, 80, 15);
    fill(0);
    text("0", LeftX + 150 + 40, LeftY + 440 + 40);

    // DEL-knap
    if (areaHover(LeftX + 50, LeftY + 440, 80, 80)) {
      if (mousePressed && !mouseClicked) {
        if (attemptedPassword.length() > 0)
          attemptedPassword = attemptedPassword.substring(0, attemptedPassword.length() - 1);
        mouseClicked = true;
      }
      if (!mousePressed) mouseClicked = false;
    }
    fill(200, 50, 50);
    rect(LeftX + 50, LeftY + 440, 80, 80, 15);
    fill(255);
    text("DEL", LeftX + 50 + 40, LeftY + 440 + 40);

    // OK-knap
    if (areaHover(LeftX + 250, LeftY + 440, 80, 80)) {
      if (mousePressed && !mouseClicked) {
        mouseClicked = true;

        if (attemptedPassword.equals(savedPassword)) {
          passwordCheckMode = false;
          switchToScreenMainMenu();
        } else {
          println("Forkert adgangskode");
          attemptedPassword = "";
          doShake = true;
          shakeTimer = 10;
          shakeDirection = 1;
        }
      }
      if (!mousePressed) mouseClicked = false;
    }
    fill(149, 146, 88);
    rect(LeftX + 250, LeftY + 440, 80, 80, 15);
    fill(0);
    text("OK", LeftX + 250 + 40, LeftY + 440 + 40);
  }

  // tilbage knappen
  if (mouseReleased &&
    mouseX >= 1800 && mouseX <= 1950 &&
    mouseY >= 30 && mouseY <= 130) {
    println(password);
    if (password) {
      passwordEntering = false;
      attemptedPassword = "";
      passwordCheckMode = true;
    } else {
      switchToScreenMainMenu();
    }
  }
}

void drawDrinkSelectionButton(int topLeftX, int topLeftY, int buttonWidth, int buttonHeight, Drink drink) {
  noStroke();

  fill(colorDark);
  rect(topLeftX, topLeftY, buttonWidth, buttonHeight);

  drink.showIcon(topLeftX+140, topLeftY+140, 240, 240);

  fill(colorText);
  textAlign(CENTER, TOP);
  textSize(36);
  text(drink.name, topLeftX+(buttonWidth/2), topLeftY);

  fill(colorText);
  textAlign(CENTER, BOTTOM);
  textSize(20);
  text(drink.importantIngredients(30), topLeftX+(buttonWidth/2), topLeftY+buttonHeight);

  if (buttonClicked(topLeftX, topLeftY, buttonWidth, buttonHeight)) {
    selectedDrink = drink;
    resetSearchBar();
  }
}
