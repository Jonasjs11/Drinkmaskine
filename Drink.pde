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
    imageMode(CENTER);
    image(icon, centerX,  centerY, imgWidth, imgHeight);
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
}

class Ingredient{
  String bottleName;
  int amount;
  
  Ingredient(String bottleName, int amount){
    this.bottleName = bottleName;
    this.amount = amount;
  }
}
