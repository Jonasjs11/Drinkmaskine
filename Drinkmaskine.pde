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
