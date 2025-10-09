class Drink{
  String name;
  ArrayList<Ingredient> usedIngredients;
  PImage icon;
  
  Drink(String name, PImage icon, ArrayList<Ingredient> usedIngredients){
    this.name = name;
    this.icon = icon;
    this.usedIngredients = usedIngredients;
  }
  
  void showIcon(int centerX, int centerY, int imgWidth, int imgHeight){
    imageMode(CENTER);
    image(icon, centerX,  centerY, imgWidth, imgHeight);
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
