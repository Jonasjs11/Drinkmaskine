boolean screenMainMenu;
boolean screenBottles;
boolean screenDrinks;
boolean screenPrepareServing;
boolean screenServing;

ArrayList<String> allBottles;
ArrayList<Drink> allDrinks;

String[] connectedBottles;

void setup(){
  size(1920, 1200);
  
  switchToScreenMainMenu();
  
  allBottles = new ArrayList<String>();
  allDrinks = new ArrayList<Drink>();
  
  connectedBottles = new String[9];
  for(int i = 0; i < connectedBottles.length; i++){
    connectedBottles[i] = "";
  }
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
