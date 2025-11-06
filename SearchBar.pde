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

ArrayList<Drink> removeNonSearchedDrink(ArrayList<Drink> original){
  ArrayList<Drink> n = new ArrayList<Drink>();
  for(int i = 0; i < original.size(); i++){
    if(original.get(i).name.contains(currentSearchBarText) || original.get(i).name.toLowerCase().contains(currentSearchBarText) || original.get(i).name.toUpperCase().contains(currentSearchBarText)){
      n.add(original.get(i));
    }
  }
  return n;
}

ArrayList<Bottle> removeNonSearchedBottle(ArrayList<Bottle> original){
  ArrayList<Bottle> n = new ArrayList<Bottle>();
  for(int i = 0; i < original.size(); i++){
    if(original.get(i).name.contains(currentSearchBarText) || original.get(i).name.toLowerCase().contains(currentSearchBarText) || original.get(i).name.toUpperCase().contains(currentSearchBarText)){
      n.add(original.get(i));
    }
  }
  return n;
}
