import java.util.Arrays;//For initialisering af drinksne ingredienser

boolean screenMainMenu;
boolean screenBottles;
boolean screenDrinks;
boolean screenPrepareServing;
boolean screenServing;

ArrayList<Bottle> allBottles;
ArrayList<Drink> allDrinks;

String[] connectedBottles;

void setup(){
  size(1920, 1200);
  
  switchToScreenMainMenu();
  
  allBottles = new ArrayList<Bottle>();
  allDrinks = new ArrayList<Drink>();
  
  connectedBottles = new String[9];
  for(int i = 0; i < connectedBottles.length; i++){
    connectedBottles[i] = "";
  }
  
  allBottles.add(new Bottle("Vodka", 37.5));
  allBottles.add(new Bottle("Tequila", 20));
  allBottles.add(new Bottle("Appelsinjuice", 0));
  
  allDrinks.add(new Drink("Tequila Sunrise", new ArrayList<Ingredient>(Arrays.asList(
  new Ingredient("Tequila", 4), new Ingredient("Appelsinjuice", 10), new Ingredient("Grenadine syrup", 1)
  ))));
  allDrinks.add(new Drink("Vodka shot", new ArrayList<Ingredient>(Arrays.asList(
  new Ingredient("Vodka", 1)
  ))));
  
  connectedBottles[0] = "Vodka"; //KUN FOR TEST
}

void draw(){
  if(screenMainMenu){
    drawMainMenuScreen();
  }
  if(screenBottles){
    drawBottlesScreen();
  }
  if(screenDrinks){
    drawDrinksScreen();
  }
  if(screenPrepareServing){
    drawPrepareServingScreen();
  }
  if(screenServing){
    drawServingScreen();
  }
}

boolean buttonClicked(int topLeftX, int topLeftY, int buttonWidth, int buttonHeight){
  if(mousePressed){
    if(mouseX >= topLeftX && mouseX <= topLeftX + buttonWidth){
      if(mouseY >= topLeftY && mouseY <= topLeftY + buttonHeight){
        return true;
      }
    }
  }
  return false;
}

ArrayList<Drink> getPossibleDrinks(){
  ArrayList<Drink> possibleDrinks = new ArrayList<Drink>();
  
  for(int d = 0; d < allDrinks.size(); d++){
    boolean hasAllIngredients = true;
    
    for(int i = 0; i < allDrinks.get(d).usedIngredients.size(); i++){
      if(hasConnectedBottle(allDrinks.get(d).usedIngredients.get(i).bottleName) == false){
        hasAllIngredients = false;
      }
    }
    
    if(hasAllIngredients){
      possibleDrinks.add(allDrinks.get(d));
    }
  }
  
  return possibleDrinks;
}

boolean hasConnectedBottle(String bottle){
  boolean hasConnectedBottle = false;
  for(int i = 0; i < connectedBottles.length; i++){
    if(connectedBottles[i] == bottle){
      hasConnectedBottle = true;
    }
  }
  return hasConnectedBottle;
}

void switchToScreenMainMenu(){
  screenMainMenu = true;
  screenBottles = false;
  screenDrinks = false;
  screenPrepareServing = false;
  screenServing = false;
}
void switchToScreenBottles(){
  screenMainMenu = false;
  screenBottles = true;
  screenDrinks = false;
  screenPrepareServing = false;
  screenServing = false;
}
void switchToScreenDrinks(){
  screenMainMenu = false;
  screenBottles = false;
  screenDrinks = true;
  screenPrepareServing = false;
  screenServing = false;
}
void switchToScreenPrepareServing(){
  screenMainMenu = false;
  screenBottles = false;
  screenDrinks = false;
  screenPrepareServing = true;
  screenServing = false;
}
void switchToScreenServing(){
  screenMainMenu = false;
  screenBottles = false;
  screenDrinks = false;
  screenPrepareServing = false;
  screenServing = true;
}
