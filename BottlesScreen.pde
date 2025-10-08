void drawBottlesScreen(){
  background(255);
  
  drawConnectedBottlesSelection();
}

void drawConnectedBottlesSelection(){
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
    int topLeftCornerX = 50+((i%2)*290);
    int topLeftCornerY = 200+((i/2)*200);
    
    fill(#D9D9D9);
    rect(topLeftCornerX, topLeftCornerY, 240, 150);
    
    fill(#000000);
    textAlign(CENTER, TOP);
    textSize(20);
    text("Flaske " + (i+1), topLeftCornerX+120, topLeftCornerY+10);
    textAlign(CENTER, CENTER);
    textSize(36);
    text(connectedBottles[i], topLeftCornerX+120, topLeftCornerY+75);
    
    if(buttonClicked(topLeftCornerX, topLeftCornerY, 240, 150)){
      println(i);
    }
  }
}
