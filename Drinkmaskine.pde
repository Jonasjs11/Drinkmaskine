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
PImage addIcon;
PImage oldMoneyKnap;
PImage oldMoneyLogo;

PImage greyBottlesIcon;

PImage DrinkMaskine;

int oldMoneyBackground = #BBA591;
int oldMoneyLight = #FAECC3;
int oldMoneyText = #000000;

boolean passwordCheckMode = false;
boolean password;
boolean mouseClicked;
boolean nonAlkohol;
boolean passwordEntering;
String enteredPassword = "";
String savedPassword = "";
String attemptedPassword = "";

int shake = 0;
int shakeTimer = 0;
float shakeDirection = 1;
boolean doShake = false;
String adgangskodeTekst = "Indtast adgangskode";

String ip = "10.194.220.129";
String[] connectionLines;
boolean triedToPing;

void setup(){
  size(1920, 1200);
  
  switchToScreenMainMenu();
  
  oldMoneyKnap = loadImage("Nyt Projekt 3 (1).png");
  
  oldMoneyLogo = loadImage("OldMoneyLogo.png");
  
  allBottles = new ArrayList<Bottle>();
  allDrinks = new ArrayList<Drink>();
  
  connectedBottles = new String[9];
  for(int i = 0; i < connectedBottles.length; i++){
    connectedBottles[i] = "";
  }
  
  loadDrinksAndBottles();
  
  filterIcon = loadImage("Filter.png");
  searchIcon = loadImage("Search.png");
  addIcon = loadImage("Add.png");

  greyBottlesIcon = loadImage("GraaFlasker.png");

  DrinkMaskine = loadImage("Drinkmaskinen.png");

  
  connectedBottles[0] = "Vodka"; //KUN FOR TEST
  
  connectionLines = null;
  triedToPing = false;
}

void draw(){
  if(millis() < 3000){
    drawSplashScreen();
    return;
  }
  
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

void roundRect(int topLeftX, int topLeftY, int rectWidth, int rectHeight, int radius){
  circle(topLeftX+radius, topLeftY+radius, radius*2);
  circle(topLeftX+rectWidth-radius, topLeftY+radius, radius*2);
  circle(topLeftX+radius, topLeftY+rectHeight-radius, radius*2);
  circle(topLeftX+rectWidth-radius, topLeftY+rectHeight-radius, radius*2);
  
  rect(topLeftX+radius, topLeftY, rectWidth-(radius*2), radius);
  rect(topLeftX+radius, topLeftY+rectHeight-radius, rectWidth-(radius*2), radius);
  
  rect(topLeftX, topLeftY+radius, rectWidth, rectHeight-(radius*2));
}

void drawSplashScreen(){
  background(oldMoneyBackground);
  
  noStroke();
  fill(oldMoneyLight);
  roundRect(width/2-325, height/2-325, 650, 650, 20);
  
  imageMode(CENTER);
  image(oldMoneyLogo, width/2, height/2, 600, 600);
}

void saveDrinksAndBottles(){
  JSONArray bottlesJSON = new JSONArray();

  for(int i = 0; i < allBottles.size(); i++){
    JSONObject bottle = new JSONObject();

    bottle.setString("name", allBottles.get(i).name);
    bottle.setFloat("alcoholPercentage", allBottles.get(i).alcoholPercentage);
    bottle.setString("iconPath", allBottles.get(i).iconPath);
    
    bottlesJSON.setJSONObject(i, bottle);
  }

  saveJSONArray(bottlesJSON, "Bottles.json");
  
  
  JSONArray drinksJSON = new JSONArray();

  for(int i = 0; i < allDrinks.size(); i++){
    JSONObject drink = new JSONObject();

    drink.setString("name", allDrinks.get(i).name);
    drink.setString("iconPath", allDrinks.get(i).iconPath);
    drink.setString("description", allDrinks.get(i).description);
    
    JSONArray ingredients = new JSONArray();
    for(int ingr = 0; ingr < allDrinks.get(i).usedIngredients.size(); ingr++){
      JSONObject ingredient = new JSONObject();
      ingredient.setString("bottleName", allDrinks.get(i).usedIngredients.get(ingr).bottleName);
      ingredient.setInt("amount", allDrinks.get(i).usedIngredients.get(ingr).amount);
      ingredients.setJSONObject(ingr, ingredient);
    }
    drink.setJSONArray("usedIngredients", ingredients);
    
    drinksJSON.setJSONObject(i, drink);
  }

  saveJSONArray(drinksJSON, "Drinks.json");
}

void loadDrinksAndBottles(){
  JSONArray bottlesJSON = loadJSONArray("Bottles.json");
  for(int i = 0; i < bottlesJSON.size(); i++){
    JSONObject bottle = bottlesJSON.getJSONObject(i);
    String iconPath = bottle.getString("iconPath");
    allBottles.add(new Bottle(bottle.getString("name"), bottle.getFloat("alcoholPercentage"), loadImage(iconPath), iconPath));
  }
  
  JSONArray drinksJSON = loadJSONArray("Drinks.json");
  for(int i = 0; i < drinksJSON.size(); i++){
    JSONObject drink = drinksJSON.getJSONObject(i);
    
    JSONArray usedIngredients = drink.getJSONArray("usedIngredients");
    ArrayList<Ingredient> ingredients = new ArrayList<Ingredient>();
    for(int ingr = 0; ingr < usedIngredients.size(); ingr++){
      JSONObject ingredient = usedIngredients.getJSONObject(ingr);
      ingredients.add(new Ingredient(ingredient.getString("bottleName"), ingredient.getInt("amount")));
    }
    
    String name = drink.getString("name");
    String description = drink.getString("description");
    String iconPath = drink.getString("iconPath");
    allDrinks.add(new Drink(name, description, loadImage(iconPath), iconPath, ingredients));
  }
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

boolean filterNonAlcoholic;
boolean filterUnderSixPercent;
void resetFilter() {
  filterNonAlcoholic = false;
  filterUnderSixPercent = false;
}
boolean showFilterCurrently;
void showFilter(int topCenterX, int topCenterY){
  int filterWidth = 200;
  int filterHeight = 110;
  
  int topLeftX = topCenterX-(filterWidth/2);
  
  fill(oldMoneyLight);
  rect(topLeftX, topCenterY, filterWidth, filterHeight);
  
  
  if(areaHover(topLeftX+10, topCenterY+10, 40, 40) && mouseReleased){ filterNonAlcoholic = !filterNonAlcoholic; }
  fill(255);
  rect(topLeftX+10, topCenterY+10, 40, 40);
  if(filterNonAlcoholic){
    fill(0);
    rect(topLeftX+15, topCenterY+15, 30, 30);
  }
  fill(oldMoneyText);
  textSize(20);
  textAlign(LEFT, CENTER);
  text("Non-alchoholic", topLeftX+60, topCenterY+30);
  
  
  if(areaHover(topLeftX+10, topCenterY+50, 40, 40) && mouseReleased){ filterUnderSixPercent = !filterUnderSixPercent; }
  fill(255);
  rect(topLeftX+10, topCenterY+60, 40, 40);
  if(filterUnderSixPercent){
    fill(0);
    rect(topLeftX+15, topCenterY+65, 30, 30);
  }
  fill(oldMoneyText);
  textSize(20);
  textAlign(LEFT, CENTER);
  text("Under 6%", topLeftX+60, topCenterY+80);
}

String currentSearchBarText = "";
float searchBarInputWaitStarted = 0;
final float searchBarInputWaitDuration = 200;
void resetSearchBar() { currentSearchBarText = ""; }
void searchBar(int topLeftX, int topLeftY, int barWidth, int barHeight){
  fill(#FFFFFF);
  circle(topLeftX+(barHeight/2), topLeftY+(barHeight/2), barHeight);
  rect(topLeftX+(barHeight/2), topLeftY, barWidth-barHeight, barHeight);
  circle(topLeftX+(barHeight/2)+barWidth-barHeight, topLeftY+(barHeight/2), barHeight);
  
  fill(#000000);
  textAlign(LEFT, CENTER);
  textSize(56);
  text(currentSearchBarText, topLeftX+barHeight, topLeftY+(barHeight/2));
  
  imageMode(CENTER);
  image(searchIcon, topLeftX+(barHeight/2), topLeftY+(barHeight/2), barHeight-20, barHeight-20);
  
  if(areaHover(topLeftX, topLeftY, barWidth, barHeight)){
    if(keyPressed && millis() - searchBarInputWaitStarted >= searchBarInputWaitDuration){
      if(key != CODED){
        if (key == BACKSPACE) {
          if (currentSearchBarText.length()>0) {
            currentSearchBarText = currentSearchBarText.substring(0, currentSearchBarText.length()-1);
          }
        } else {
          currentSearchBarText += key;
        }
      } 
      searchBarInputWaitStarted = millis();
    }
  }
}

ArrayList<Drink> removeNonSearched(ArrayList<Drink> original){
  ArrayList<Drink> n = new ArrayList<Drink>();
  for(int i = 0; i < original.size(); i++){
    if(original.get(i).name.contains(currentSearchBarText) || original.get(i).name.toLowerCase().contains(currentSearchBarText) || original.get(i).name.toUpperCase().contains(currentSearchBarText)){
      n.add(original.get(i));
    }
  }
  return n;
}

ArrayList<Drink> getPossibleDrinks(){
  ArrayList<Drink> possibleDrinks = new ArrayList<Drink>();
  
  for(int d = 0; d < allDrinks.size(); d++){
    //PREPARE SERVING SCREEN SETTINGS
    if(nonAlkohol){
      if(allDrinks.get(d).isAlcoholFree() == false){
        continue;
      }
    }
    
    //FILTERS
    if(filterNonAlcoholic){
      if(allDrinks.get(d).isAlcoholFree() == false){
        continue;
      }
    }
    if(filterUnderSixPercent){
      if(allDrinks.get(d).getAlcoholPercent() > 0.06){
        continue;
      }
    }
    
    //IS POSSIBLE WITH BOTTLE COMBINATION
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
    if(connectedBottles[i].equals(bottle)){
      hasConnectedBottle = true;
    }
  }
  return hasConnectedBottle;
}

int getConnectedBottleIndex(String usedIngredients) {
  for (int i = 0; i < connectedBottles.length; i++) {
    if (connectedBottles[i].equals(usedIngredients)) {
      return i;
    }
  }
  return -1;
}

Bottle findBottleFromName(String name){
  for(int i = 0; i < allBottles.size(); i++){
    if(allBottles.get(i).name.equals(name)){
      return allBottles.get(i);
    }
  }
  return null;
}

void switchToScreenMainMenu(){
  screenMainMenu = true;
  screenBottles = false;
  screenDrinks = false;
  screenPrepareServing = false;
  screenServing = false;
  resetSearchBar();
  selectedBottleToConnect = null;
  resetFilter();
}
void switchToScreenBottles(){
  screenMainMenu = false;
  screenBottles = true;
  screenDrinks = false;
  screenPrepareServing = false;
  screenServing = false;
  resetSearchBar();
  selectedBottleToConnect = null;
  resetFilter();
  updateScrollbarToView(100, 2000, 1000);
  resetScrollbar();
}
void switchToScreenDrinks(){
  screenMainMenu = false;
  screenBottles = false;
  screenDrinks = true;
  screenPrepareServing = false;
  screenServing = false;
  resetSearchBar();
  selectedBottleToConnect = null;
  resetFilter();
}
void switchToScreenPrepareServing(){
  screenMainMenu = false;
  screenBottles = false;
  screenDrinks = false;
  screenPrepareServing = true;
  screenServing = false;
  resetSearchBar();
  selectedBottleToConnect = null;
  resetFilter();
}
void switchToScreenServing(){
  screenMainMenu = false;
  screenBottles = false;
  screenDrinks = false;
  screenPrepareServing = false;
  screenServing = true;
  resetSearchBar();
  selectedBottleToConnect = null;
  resetFilter();
}
