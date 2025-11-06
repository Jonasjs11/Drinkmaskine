Bottle selectedBottleToConnect;

void drawBottlesScreen() {
  background(oldMoneyBackground);

  drawConnectedBottles(selectedBottleToConnect != null);

  noStroke();
  fill(oldMoneyLight);
  rect(630, 0, 15, 1200);

  drawAllBottles();
}

void drawConnectedBottles(boolean visTilføjFlasker) {
  noStroke();
  fill(oldMoneyLight);
  rect(50, 50, 530, 100);
  fill(#FFFFFF);
  rect(60, 60, 510, 80);
  fill(oldMoneyText);
  textAlign(CENTER, CENTER);
  textSize(56);
  text("Tilkoblede flasker", 315, 100);

  for (int i = 0; i < connectedBottles.length; i++) {
    int topLeftCornerX = 50+((i%2)*290);
    int topLeftCornerY = 200+((i/2)*200);

    fill(oldMoneyLight);
    rect(topLeftCornerX, topLeftCornerY, 240, 150);

    if (connectedBottles[i] == "") {
      imageMode(CENTER);
      image(greyBottlesIcon, topLeftCornerX+120, topLeftCornerY+85, 68, 112);
    }


    fill(oldMoneyText);
    textAlign(CENTER, TOP);
    textSize(20);
    text("Flaske " + (i+1), topLeftCornerX+120, topLeftCornerY+10);
    textAlign(CENTER, CENTER);
    textSize(36);
    text(connectedBottles[i], topLeftCornerX+120, topLeftCornerY+75);
    if (visTilføjFlasker && connectedBottles[i] == "") {
      text("Tilføj flaske", topLeftCornerX+120, topLeftCornerY+75);
    }

    if (buttonClicked(topLeftCornerX, topLeftCornerY, 240, 150)) {
      if (selectedBottleToConnect != null) {
        connectedBottles[i] = selectedBottleToConnect.name;
        selectedBottleToConnect = null;
      } else if (connectedBottles[i] != null && !connectedBottles[i].isEmpty()) {
        connectedBottles[i] = ""; // gør pladsen tom igen
      }

      if (screenMainMenu) {
        switchToScreenBottles();
      }
    }
  }
}

boolean selectedBottleThisTime;
void drawAllBottles() {
  selectedBottleThisTime = false;
  ArrayList<Bottle> possibleBottles = removeNonSearchedBottle(getFilteredListOfBottles(allBottles));
  for (int i = 0; i < possibleBottles.size(); i++) {
    float topLeftX = 695+((i%3)*447.5);
    float topLeftY = 205+((i/3)*447.5) - getScrollViewOffset();

    drawBottleSelectionButton(possibleBottles.get(i), topLeftX, topLeftY);
  }
  selectedBottleThisTime = false;
  float bottomYOfBottomBottle = 205+(((possibleBottles.size()-1)/3)*447.5);
  updateScrollbarAreaAndView(100, int(bottomYOfBottomBottle+280+50), 1000);
  
  noStroke();
  fill(oldMoneyLight);
  rect(695, 0, 1175, 100);
  
  searchBar(705, 10, 885, 80);
  
  imageMode(CENTER);
  image(filterIcon, 1640, 50, 80, 80);
  if(areaHover(1640-40, 50-40, 80, 80) && mouseReleased){
    showFilterCurrently = !showFilterCurrently;
  }
  if(showFilterCurrently){ showFilter(1640, 120); }
  
  imageMode(CENTER);
  image(addIcon, 1730, 50, 80, 80);
  
  //tilbage knappen
  imageMode(CENTER);
  image(oldMoneyLogo, 1820, 50, 80, 80);
  if (mouseReleased && areaHover(1820-40, 50-40, 80, 80)) {
    switchToScreenMainMenu();
  }
  
  drawScrollbar(width, 150, 20, false);
}



void drawBottleSelectionButton(Bottle bottle, float topLeftX, float topLeftY){
  noStroke();
  fill(oldMoneyLight);
  rect(topLeftX, topLeftY, 280, 280);
    
  bottle.showIcon(int(topLeftX)+140, int(topLeftY)+140, 240, 240);
    
  fill(oldMoneyText);
  textAlign(CENTER, TOP);
  textSize(36);
  text(getFormattedString(bottle.name, 12, 16), topLeftX+140, topLeftY);

  fill(oldMoneyText);
  textAlign(CENTER, BOTTOM);
  textSize(36);
  text(nf(bottle.alcoholPercentage)+"%", topLeftX+140, topLeftY+280);

  if (mouseReleased && selectedBottleThisTime == false) {
    if (areaHover((int)topLeftX, (int)topLeftY, 280, 280)) {
      selectedBottleToConnect = bottle;
      selectedBottleThisTime = true;
    } else {
      selectedBottleToConnect = null;
    }
  }
}
