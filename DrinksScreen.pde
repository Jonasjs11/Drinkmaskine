void drawDrinksScreen() {
  background(oldMoneyBackground);

  int xStart = 100;
  int yStart = 200;
  int spacingX = 240;
  int spacingY = 100;
  int drinkNumber = 0;
  
  ArrayList<Drink> shownDrinks = removeNonSearchedDrink(getFilteredListOfDrinks(allDrinks));//SKAL BRUGES!!!
  for (int col = 0; col < 4; col++) {
    for (int row = 0; row < 3; row++) {
      fill(oldMoneyLight);
      int x = xStart + col * (250 + spacingX);
      int y = yStart + row * (250 + spacingY) - getScrollViewOffset();
      rect(x, y, 250, 250, 20);
      allDrinks.get(drinkNumber).showIcon(x+125, y+125, 250, 250);
      fill(oldMoneyText);
      allDrinks.get(drinkNumber).showName(x+125, y+25);
      allDrinks.get(drinkNumber).showImportantIngredients(x+125, y+225, 18);
      if (drinkNumber < 12) {
        drinkNumber += 1;
      }
    }
  }
  float bottomYOfBottomDrink = yStart + 3 * (250 + spacingY);//SKAL FIXES!!!
  updateScrollbarAreaAndView(100, int(bottomYOfBottomDrink)+180+50, 1000);
  
  fill(oldMoneyLight);
  rect(100, 0, 1720, 100);
  searchBar(110, 10, 1440, 80);
  imageMode(CENTER);
  image(addIcon, 1680, 50, 80, 80);
  
  image(filterIcon, 1590, 50, 80, 80);
  if (areaHover(1590-40, 50-40, 80, 80) && mouseReleased) {
    showFilterCurrently = !showFilterCurrently;
  }
  if (showFilterCurrently) {
    showFilter(1590, 120);
  }
  
  image(oldMoneyLogo, 1770, 50, 80, 80);
  //tilbage knappen
  if (mouseReleased && areaHover(1770-40, 50-40, 80, 80)) {
    switchToScreenMainMenu();
  }
  
  drawScrollbar(width, 150, 20, false);
}
