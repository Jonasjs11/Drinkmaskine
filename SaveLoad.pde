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
