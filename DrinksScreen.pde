void drawDrinksScreen() {
  background(oldMoneyBackground);

  fill(oldMoneyLight);

  int xStart = 100;
  int yStart = 200;
  int spacingX = 240;
  int spacingY = 100;
  int drinkNumber = 0;

  rect(100, 0, 1720, 100);
  for (int col = 0; col < 4; col++) {
    for (int row = 0; row < 3; row++) {
      fill(oldMoneyLight);
      int x = xStart + col * (250 + spacingX);
      int y = yStart + row * (250 + spacingY);
      rect(x, y, 250, 250, 20);
      allDrinks.get(drinkNumber).showIcon(x+125, y+125, 250, 250);
      fill(oldMoneyText);
      allDrinks.get(drinkNumber).showName(x+125, y+25);
      allDrinks.get(drinkNumber).showImportantIngredients(x+125, y+225, 30);
      if (drinkNumber < 3) {
        drinkNumber += 1;
      }
    }
  }
  
  searchBar(120, 10, 1400, 80);
  image(filterIcon, 1650, 50, 80, 80);
  image(oldMoneyKnap,1750, 59);
  
  //tilbage knappen
  if (mouseReleased &&
    mouseX >= 1749 && mouseX <= 1900 &&
    mouseY >= 40 && mouseY <= 120) {
    switchToScreenMainMenu();
  }
}
