
void drawMainMenuScreen(){
  background(255);
  
  drawConnectedBottles();
  
  noStroke();
  fill(#D9D9D9);
  rect(630, 0, 15, 1200);
  rect(1275, 0, 15, 1200);
  
  drawChooseScreenButtons();
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
}

void drawConnectedBottles(){
  noStroke();
  fill(#D9D9D9);
  rect(50, 50, 530, 100);
  fill(#FFFFFF);
  rect(60, 60, 510, 80);
  fill(#000000);
  textAlign(CENTER, CENTER);
  textSize(56);
  text("Tilkoblede flasker", 315, 100);
  
  for(int i = 0; i < connectedBottles.length; i++){
    fill(#D9D9D9);
    float topLeftCornerX = 50+((i%2)*290);
    float topLeftCornerY = 200+((i/2)*200);
    rect(topLeftCornerX, topLeftCornerY, 240, 150);
    fill(#000000);
    textAlign(CENTER, TOP);
    textSize(20);
    text("Flaske " + (i+1), topLeftCornerX+120, topLeftCornerY+10);
    textAlign(CENTER, CENTER);
    textSize(36);
    text(connectedBottles[i], topLeftCornerX+120, topLeftCornerY+75);
  }
}
