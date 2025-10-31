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

PImage greyBottlesIcon;

PImage DrinkMaskine;


int oldMoneyBackground = #BBA591;
int oldMoneyLight = #FAECC3;
int oldMoneyText = #000000;

void setup(){
  size(1920, 1200);
  
  switchToScreenMainMenu();
  
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

void saveDrinksAndBottles(){
  JSONArray bottlesJSON = new JSONArray();

  for(int i = 0; i < allBottles.size(); i++){
    JSONObject bottle = new JSONObject();

    bottle.setString("name", allBottles.get(i).name);
    bottle.setFloat("alcoholPercentage", allBottles.get(i).alcoholPercentage);
    
    bottlesJSON.setJSONObject(i, bottle);
  }

  saveJSONArray(bottlesJSON, "Bottles.json");
  
  
  JSONArray drinksJSON = new JSONArray();

  for(int i = 0; i < allDrinks.size(); i++){
    JSONObject drink = new JSONObject();

    drink.setString("name", allDrinks.get(i).name);
    drink.setString("iconPath", allDrinks.get(i).iconPath);
    
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
    allBottles.add(new Bottle(bottle.getString("name"), bottle.getFloat("alcoholPercentage")));
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
    String iconPath = drink.getString("iconPath");
    allDrinks.add(new Drink(name, loadImage(iconPath), iconPath, ingredients));
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

void switchToScreenMainMenu(){
  screenMainMenu = true;
  screenBottles = false;
  screenDrinks = false;
  screenPrepareServing = false;
  screenServing = false;
  resetSearchBar();
  selectedBottleToConnect = null;
}
void switchToScreenBottles(){
  screenMainMenu = false;
  screenBottles = true;
  screenDrinks = false;
  screenPrepareServing = false;
  screenServing = false;
  resetSearchBar();
  selectedBottleToConnect = null;
}
void switchToScreenDrinks(){
  screenMainMenu = false;
  screenBottles = false;
  screenDrinks = true;
  screenPrepareServing = false;
  screenServing = false;
  resetSearchBar();
  selectedBottleToConnect = null;
}
void switchToScreenPrepareServing(){
  screenMainMenu = false;
  screenBottles = false;
  screenDrinks = false;
  screenPrepareServing = true;
  screenServing = false;
  resetSearchBar();
  selectedBottleToConnect = null;
}
void switchToScreenServing(){
  screenMainMenu = false;
  screenBottles = false;
  screenDrinks = false;
  screenPrepareServing = false;
  screenServing = true;
  resetSearchBar();
  selectedBottleToConnect = null;
}
