int colorBackground = #FFFFFF;
int colorDark = #D9D9D9;
int colorText = #000000;

Drink selectedDrink;

ArrayList<Drink> possibleDrinksTemp;

void drawServingScreen(){
  background(colorBackground);
  
  if(selectedDrink == null){
    possibleDrinksTemp = getPossibleDrinks();
    if(possibleDrinksTemp.size() > 0) { 
      selectedDrink = possibleDrinksTemp.get(0);
    }
  }
  
  drawSelectedDrinkPart();
  
  fill(colorDark);
  rect(1090, 0, 10, 1200);
  
  drawDrinkSelectionPart();
}

void drawSelectedDrinkPart(){
  noStroke();
  
  if(selectedDrink == null){
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
  for(int i = 0; i < selectedDrink.usedIngredients.size(); i++){
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
  
  
  
  fill(colorDark);
  if(areaHover(550, 1025, 490, 125)){
    fill(colorDark+#101010);
    if(mousePressed){
      fill(colorDark-#101010);
    }
    if(mouseReleased){
      println("HÆLD DRINK OP HER");
    }
  }
  rect(550, 1025, 490, 125);
  
  fill(colorText);
  textAlign(CENTER, CENTER);
  textSize(64);
  text("Begynd servering", 795, 1087.5);
}

void drawDrinkSelectionPart(){
  fill(colorDark);
  rect(1150, 0, 720, 100);
  
  searchBar(1160, 10, 509, 80);
  
  imageMode(CENTER);
  image(filterIcon, 1709, 50, 80, 80);
  
  ArrayList<Drink> possibleDrinkChoices = removeNonSearched(getPossibleDrinks());
  
  for(int i = 0; i < possibleDrinkChoices.size(); i++){
    drawDrinkSelectionButton(1150+((i%2)*440), 150+((i/2)*440), 280, 280, possibleDrinkChoices.get(i));
  }
}

void drawDrinkSelectionButton(int topLeftX, int topLeftY, int buttonWidth, int buttonHeight, Drink drink){
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
  
  if(buttonClicked(topLeftX, topLeftY, buttonWidth, buttonHeight)){
    selectedDrink = drink;
    resetSearchBar();
  }
}
