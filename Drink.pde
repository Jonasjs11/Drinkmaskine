class Drink{
  String name;
  ArrayList<Ingredient> usedIngredients;
  
  Drink(String name, ArrayList<Ingredient> usedIngredients){
    this.name = name;
    this.usedIngredients = usedIngredients;
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
