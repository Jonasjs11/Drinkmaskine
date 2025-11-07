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

PImage drinkScreenButtonIcon;
PImage bottlesScreenButtonIcon;
PImage prepareServingScreenButtonIcon;

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
color passwordIncorrectTextColor = 0;

String ip = "10.194.220.129";
String[] connectionLines;
boolean triedToPing;

PFont oldMoneyFont;
PFont rustic;

void setup() {
  oldMoneyFont = loadFont("oldMoneyFont.vlw");
  rustic = loadFont("Rustic.vlw");
  size(1920, 1200);

  switchToScreenMainMenu();

  oldMoneyKnap = loadImage("Nyt Projekt 3 (1).png");
  oldMoneyLogo = loadImage("OldMoneyLogo.png");

  allBottles = new ArrayList<Bottle>();
  allDrinks = new ArrayList<Drink>();

  connectedBottles = new String[9];
  for (int i = 0; i < connectedBottles.length; i++) {
    connectedBottles[i] = "";
  }

  loadDrinksAndBottles();

  filterIcon = loadImage("Filter.png");
  searchIcon = loadImage("Search.png");
  addIcon = loadImage("Add.png");
  greyBottlesIcon = loadImage("GraaFlasker.png");
  DrinkMaskine = loadImage("Drinkmaskinen.png");
  
  drinkScreenButtonIcon = loadImage("DrinksSkærmKnapIkon.png");
  bottlesScreenButtonIcon = loadImage("BottlesSkærmKnapIkon.png");
  prepareServingScreenButtonIcon = loadImage("PrepareServeringSkærmKnapIkon.png");
  
  connectedBottles[0] = "Vodka"; //KUN FOR TEST

  connectionLines = null;
  triedToPing = false;
}

void draw() {


  if (millis() < 3000) {
    drawSplashScreen();
    return;
  }

  if (screenMainMenu) {
    drawMainMenuScreen();
  }
  if (screenBottles) {
    drawBottlesScreen();
  }
  if (screenDrinks) {
    drawDrinksScreen();
  }
  if (screenPrepareServing) {
    drawPrepareServingScreen();
  }
  if (screenServing) {
    drawServingScreen();
  }

  mouseReleased = false;
}

void mouseReleased() {
  mouseReleased = true;
}

void roundRect(int topLeftX, int topLeftY, int rectWidth, int rectHeight, int radius) {
  circle(topLeftX+radius, topLeftY+radius, radius*2);
  circle(topLeftX+rectWidth-radius, topLeftY+radius, radius*2);
  circle(topLeftX+radius, topLeftY+rectHeight-radius, radius*2);
  circle(topLeftX+rectWidth-radius, topLeftY+rectHeight-radius, radius*2);

  rect(topLeftX+radius, topLeftY, rectWidth-(radius*2), radius);
  rect(topLeftX+radius, topLeftY+rectHeight-radius, rectWidth-(radius*2), radius);

  rect(topLeftX, topLeftY+radius, rectWidth, rectHeight-(radius*2));
}

void drawSplashScreen() {
  background(oldMoneyBackground);

  noStroke();
  fill(oldMoneyLight);
  roundRect(width/2-325, height/2-325, 650, 650, 20);

  imageMode(CENTER);
  image(oldMoneyLogo, width/2, height/2, 600, 600);
}

boolean buttonClicked(int topLeftX, int topLeftY, int buttonWidth, int buttonHeight) {
  if (mouseReleased) {
    return areaHover(topLeftX, topLeftY, buttonWidth, buttonHeight);
  }
  return false;
}

boolean areaHover(int topLeftX, int topLeftY, int buttonWidth, int buttonHeight) {
  if (mouseX >= topLeftX && mouseX <= topLeftX + buttonWidth) {
    if (mouseY >= topLeftY && mouseY <= topLeftY + buttonHeight) {
      return true;
    }
  }
  return false;
}

ArrayList<Drink> getPossibleDrinks() {
  ArrayList<Drink> possibleDrinks = new ArrayList<Drink>();

  for (int d = 0; d < allDrinks.size(); d++) {
    //PREPARE SERVING SCREEN SETTINGS
    if (nonAlkohol) {
      if (allDrinks.get(d).isAlcoholFree() == false) {
        continue;
      }
    }

    //FILTERS
    if (filterNonAlcoholic) {
      if (allDrinks.get(d).isAlcoholFree() == false) {
        continue;
      }
    }
    if (filterUnderSixPercent) {
      if (allDrinks.get(d).getAlcoholPercent() > 0.06) {
        continue;
      }
    }

    //IS POSSIBLE WITH BOTTLE COMBINATION
    boolean hasAllIngredients = true;
    for (int i = 0; i < allDrinks.get(d).usedIngredients.size(); i++) {
      if (hasConnectedBottle(allDrinks.get(d).usedIngredients.get(i).bottleName) == false) {
        hasAllIngredients = false;
      }
    }

    if (hasAllIngredients) {
      possibleDrinks.add(allDrinks.get(d));
    }
  }

  return possibleDrinks;
}

boolean hasConnectedBottle(String bottle) {
  boolean hasConnectedBottle = false;
  for (int i = 0; i < connectedBottles.length; i++) {
    if (connectedBottles[i].equals(bottle)) {
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

Bottle findBottleFromName(String name) {
  for (int i = 0; i < allBottles.size(); i++) {
    if (allBottles.get(i).name.equals(name)) {
      return allBottles.get(i);
    }
  }
  return null;
}

String getFormattedString(String s, int maxLineSize, int hardLimit) {
  String formatted = "";
  int charsAdded = 0;
  for (int i = 0; i < s.length(); i++) {
    formatted += s.substring(i, i+1);
    charsAdded++;

    if(charsAdded > maxLineSize && s.substring(i, i+1).equals(" ")){
      formatted += "\n";
      charsAdded = 0;
      continue;
    }
    if(charsAdded > hardLimit){
      formatted += "-\n";
      charsAdded = 0;
      continue;
    }
  }
  return formatted;
}

void switchToScreenMainMenu() {
  screenMainMenu = true;
  screenBottles = false;
  screenDrinks = false;
  screenPrepareServing = false;
  screenServing = false;
  resetSearchBar();
  selectedBottleToConnect = null;
  resetFilter();
}
void switchToScreenBottles() {
  screenMainMenu = false;
  screenBottles = true;
  screenDrinks = false;
  screenPrepareServing = false;
  screenServing = false;
  resetSearchBar();
  selectedBottleToConnect = null;
  resetFilter();
  updateScrollbarAreaAndView(100, 2000, 1000);
  resetScrollbar();
}
void switchToScreenDrinks() {
  screenMainMenu = false;
  screenBottles = false;
  screenDrinks = true;
  screenPrepareServing = false;
  screenServing = false;
  resetSearchBar();
  selectedBottleToConnect = null;
  resetFilter();
}
void switchToScreenPrepareServing() {
  screenMainMenu = false;
  screenBottles = false;
  screenDrinks = false;
  screenPrepareServing = true;
  screenServing = false;
  resetSearchBar();
  selectedBottleToConnect = null;
  resetFilter();
}
void switchToScreenServing() {
  screenMainMenu = false;
  screenBottles = false;
  screenDrinks = false;
  screenPrepareServing = false;
  screenServing = true;
  resetSearchBar();
  selectedBottleToConnect = null;
  resetFilter();
}
