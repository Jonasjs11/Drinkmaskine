class Drink{
  String name;
  String description;
  PImage icon;
  String iconPath;
  ArrayList<Ingredient> usedIngredients;
  
  Drink(String name, String description, PImage icon, String iconPath, ArrayList<Ingredient> usedIngredients){
    this.name = name;
    this.description = description;
    this.icon = icon;
    this.iconPath = iconPath;
    this.usedIngredients = usedIngredients;
  }
  
  void showIcon(int centerX, int centerY, int imgWidth, int imgHeight){
    if(icon == null){
      fill(255);
      rect(centerX-imgWidth/2, centerY-imgHeight/2, imgWidth, imgHeight);
      
      textAlign(CENTER, CENTER);
      fill(0);
      textSize(imgHeight/2);
      text("?", centerX, centerY);
      return;
    }
    
    imageMode(CENTER);
    image(icon, centerX,  centerY, imgWidth, imgHeight);
  }
  
  boolean isAlcoholFree(){
    boolean alcoholFree = true;
    for(int i = 0; i < usedIngredients.size(); i++){
      Bottle b = findBottleFromName(usedIngredients.get(i).bottleName);
      if(b == null){
        alcoholFree = false;
        println("Unable to find bottle: " + usedIngredients.get(i).bottleName);
        continue;
      }
      if(b.isAlchoholFree() == false){
        alcoholFree = false;
      }
    }
    return alcoholFree;
  }
  
  float getAlcoholPercent(){
    float totalVolume = 0;
    float alcoholVolume = 0;
    for(int i = 0; i < usedIngredients.size(); i++){
      Bottle b = findBottleFromName(usedIngredients.get(i).bottleName);
      if(b == null){
        println("Unable to find bottle: " + usedIngredients.get(i).bottleName);
        alcoholVolume += 100000;
        continue;
      }
      
      totalVolume += usedIngredients.get(i).amount;
      alcoholVolume += usedIngredients.get(i).amount * (b.alcoholPercentage * 0.01);
    }
    return alcoholVolume/totalVolume;
  }
  
  String importantIngredients(int maxLength){
    String important = "";
    for(int i = 0; i < usedIngredients.size(); i++){
      String possibleAddition = usedIngredients.get(i).bottleName + ", ";
      if(important.length() + possibleAddition.length() <= maxLength){
        important += possibleAddition;
      }
    }
    important = important.substring(0, important.length()-2);
    return important;
  }
  
  String getFormattedDescription(int maxLineSize, int hardLimit){
    String formatted = "";
    int charsAdded = 0;
    for(int i = 0; i < description.length(); i++){
      formatted += description.substring(i, i+1);
      charsAdded++;
      if(charsAdded > hardLimit){
        formatted += "-\n";
        charsAdded = 0;
        continue;
      }
      if(charsAdded > maxLineSize && description.substring(i, i+1).equals(" ")){
        formatted += "\n";
        charsAdded = 0;
      }
    }
    return formatted;
  }
}

class Ingredient{
  String bottleName;
  int amount;
  
  Ingredient(String bottleName, int amount){
    this.bottleName = bottleName;
    this.amount = amount;
  }
}
