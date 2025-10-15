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
  
  String importantIngredients(){
    String important = "";
    for(int i = 0; i < usedIngredients.size(); i++){
      important += usedIngredients.get(i).bottleName + ", ";
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
