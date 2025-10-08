int colorBackground, colorDark, colorText;

Drink selectedDrink;

void drawServingScreen(){
  background(255);
  
  if(selectedDrink == null){
    selectedDrink = allDrinks.get(0);
  }
  
  drawSelectedDrinkPart();
  drawDrinkSelectionPart();
}

void drawSelectedDrinkPart(){
  
}

void drawDrinkSelectionPart(){
  
}
