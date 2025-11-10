void drawDrinksScreen() {
  background(oldMoneyBackground);

  fill(oldMoneyLight);

  int LeftX = 100;
  int LeftY = 200;
  int spacingX = 240;
  int spacingY = 100;

  int drinksPerRow = 4;
  int boxWidth = 250;
  int boxHeight = 250;

  ArrayList<Drink> shownDrinks = removeNonSearchedDrink(getFilteredListOfDrinks(allDrinks));

  int totalDrinks = shownDrinks.size();
  
  rect(100, 0, 1720, 100);
  
  for (int drinkNumber = 0; drinkNumber < totalDrinks; drinkNumber++) {
    int col = drinkNumber % drinksPerRow;
    int row = drinkNumber / drinksPerRow;

    int x = LeftX + col * (boxWidth + spacingX);
    int y = LeftY + row * (boxHeight + spacingY);

    fill(oldMoneyLight);
    rect(x, y, boxWidth, boxHeight, 20);

    Drink d = shownDrinks.get(drinkNumber);

    d.showIcon(x + boxWidth/2, y + boxHeight/2, boxWidth, boxHeight);
    fill(oldMoneyText);
    d.showName(x + boxWidth/2, y + 25);
    d.showImportantIngredients(x + boxWidth/2, y + boxHeight - 25, 30);
  }
  
  float bottomYOfBottomDrink = LeftY + 3 * (250 + spacingY);//SKAL FIXES!!!  - HVORDAN???????!!!!!!!!?????????
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
