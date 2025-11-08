boolean filterNonAlcoholic;
boolean filterUnderSixPercent;

boolean showFilterCurrently;

void resetFilter() {
  showFilterCurrently = false;
  filterNonAlcoholic = false;
  filterUnderSixPercent = false;
}

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

ArrayList<Bottle> getFilteredListOfBottles(ArrayList<Bottle> original){
  ArrayList<Bottle> filtered = new ArrayList<Bottle>();
  
  for(int i = 0; i < original.size(); i++){
    if(filterNonAlcoholic){
      if(original.get(i).alcoholPercentage != 0){
        continue;
      }
    }
    if(filterUnderSixPercent){
      if(original.get(i).alcoholPercentage > 0.06){
        continue;
      }
    }
    
    filtered.add(original.get(i));
  }
    
  return filtered;
}

ArrayList<Drink> getFilteredListOfDrinks(ArrayList<Drink> original){
  ArrayList<Drink> filtered = new ArrayList<Drink>();
  
  for(int i = 0; i < original.size(); i++){
    if (filterNonAlcoholic) {
      if (allDrinks.get(i).isAlcoholFree() == false) {
        continue;
      }
    }
    if (filterUnderSixPercent) {
      if (allDrinks.get(i).getAlcoholPercent() > 0.06) {
        continue;
      }
    }
    
    filtered.add(original.get(i));
  }
    
  return filtered;
}
