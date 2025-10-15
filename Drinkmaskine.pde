import java.util.Arrays;//For initialisering af drinksne ingredienser

boolean screenMainMenu;
boolean screenBottles;
boolean screenDrinks;
boolean screenPrepareServing;
boolean screenServing;

ArrayList<Bottle> allBottles;
ArrayList<Drink> allDrinks;

String[] connectedBottles;

boolean mouseReleased;

PImage filterIcon;
PImage searchIcon;

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
  
  allDrinks.add(new Drink("Tequila Sunrise", loadImage("TequilaSunrise.png"), new ArrayList<Ingredient>(Arrays.asList(
  new Ingredient("Tequila", 4), new Ingredient("Appelsinjuice", 10), new Ingredient("Grenadine syrup", 1)
  ))));
  allDrinks.add(new Drink("Vodka shot", loadImage("TequilaSunrise.png"), new ArrayList<Ingredient>(Arrays.asList(
  new Ingredient("Vodka", 1)
  ))));
  allDrinks.add(new Drink("Rom og Cola", loadImage("TequilaSunrise.png"), new ArrayList<Ingredient>(Arrays.asList(
  new Ingredient("Vodka", 1)
  ))));
  allDrinks.add(new Drink("Whiskey sour", loadImage("TequilaSunrise.png"), new ArrayList<Ingredient>(Arrays.asList(
  new Ingredient("Vodka", 1)
  ))));
  
  filterIcon = loadImage("Filter.png");
  searchIcon = loadImage("Search.png");
  
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
  
  mouseReleased = false;
}

void mouseReleased(){
  mouseReleased = true;
}

boolean buttonClicked(int topLeftX, int topLeftY, int buttonWidth, int buttonHeight){
  if(mouseReleased){
    return areaHover(topLeftX, topLeftY, buttonWidth, buttonHeight);
  }
  return false;
}

boolean areaHover(int topLeftX, int topLeftY, int buttonWidth, int buttonHeight){
  if(mouseX >= topLeftX && mouseX <= topLeftX + buttonWidth){
    if(mouseY >= topLeftY && mouseY <= topLeftY + buttonHeight){
      return true;
    }
  }
  return false;
}

String currentSearchBarText;
void resetSearchBar() { currentSearchBarText = ""; }
void searchBar(int topLeftX, int topLeftY, int barWidth, int barHeight){
  fill(#FFFFFF);
  circle(topLeftX+(barHeight/2), topLeftY+(barHeight/2), barHeight);
  rect(topLeftX+(barHeight/2), topLeftY, barWidth-barHeight, barHeight);
  circle(topLeftX+(barHeight/2)+barWidth-barHeight, topLeftY+(barHeight/2), barHeight);
  fill(#000000);
  textAlign(LEFT, CENTER);
  textSize(56);
  text(currentSearchBarText, topLeftX+(barHeight/2), topLeftY+(barHeight/2));
  if(areaHover(topLeftX, topLeftY, barWidth, barHeight)){
    if(keyPressed){
      currentSearchBarText += key;
    }
  }
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
  resetSearchBar();
}
void switchToScreenBottles(){
  screenMainMenu = false;
  screenBottles = true;
  screenDrinks = false;
  screenPrepareServing = false;
  screenServing = false;
  resetSearchBar();
}
void switchToScreenDrinks(){
  screenMainMenu = false;
  screenBottles = false;
  screenDrinks = true;
  screenPrepareServing = false;
  screenServing = false;
  resetSearchBar();
}
void switchToScreenPrepareServing(){
  screenMainMenu = false;
  screenBottles = false;
  screenDrinks = false;
  screenPrepareServing = true;
  screenServing = false;
  resetSearchBar();
}
void switchToScreenServing(){
  screenMainMenu = false;
  screenBottles = false;
  screenDrinks = false;
  screenPrepareServing = false;
  screenServing = true;
  resetSearchBar();
}
