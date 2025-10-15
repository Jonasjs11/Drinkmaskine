
void drawMainMenuScreen(){
  background(255);
  
  drawConnectedBottles(true);
  
  noStroke();
  fill(#D9D9D9);
  rect(630, 0, 15, 1200);
  rect(1275, 0, 15, 1200);
  
  drawChooseScreenButtons();
  
  drawConnectionToMachine();
}

void drawChooseScreenButtons(){
  noStroke();
  fill(#D9D9D9);
  rect(1340, 50, 530, 300);
  rect(1340, 450, 530, 300);
  rect(1340, 850, 530, 300);
  
  fill(#000000);
  textAlign(CENTER, CENTER);
  textSize(56);
  text("Drinks", 1605, 150);
  text("Flasker", 1605, 550);
  text("Server", 1605, 950);
  textSize(36);
  text("Tilføj, fjern og ændre på\ndrinksne i systemet", 1605, 300);
  text("Tilføj, fjern og ændre på\nflaskerne i systemet", 1605, 700);
  text("Gør klar til serverings-\nskærmen", 1605, 1100);
  
  if(buttonClicked(1340, 50, 530, 300)){
    switchToScreenDrinks();
  }
  if(buttonClicked(1340, 450, 530, 300)){
    switchToScreenBottles();
  }
  if(buttonClicked(1340, 850, 530, 300)){
    switchToScreenPrepareServing();
  }
}

void drawConnectionToMachine(){
  noStroke();
  fill(#D9D9D9);
  
  rect(695, 50, 530, 530);
  
  rect(775, 630, 370, 100);
  
  fill(#000000);
  textAlign(CENTER, CENTER);
  textSize(56);
  text("Disconnect", 960, 680);
}
