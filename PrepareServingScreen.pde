void drawPrepareServingScreen(){
  background(255);
  
  drawColorschemeSelection();
  drawServingSettings();
  drawBeginServingButton();
}

void drawServingSettings(){
  
}

void drawBeginServingButton(){
  noStroke();
  
  fill(#D9D9D9);
  if(areaHover(983, 1050, 500, 100)){
    fill(#F0F0F0);
    if(mouseReleased){
      switchToScreenServing();
    }
  }
  if(mousePressed){
    fill(#24F064);
  }
  rect(983, 1050, 500, 100);
  
  fill(#000000);
  textAlign(CENTER, CENTER);
  textSize(56);
  text("Begynd servering", 1233, 1100);
}

void drawColorschemeSelection(){
  noStroke();
  
  fill(#D9D9D9);
  rect(50, 150, 430, 100);
  
  fill(#FFFFFF);
  rect(60, 160, 410, 80);
  
  fill(#000000);
  textAlign(CENTER, CENTER);
  textSize(56);
  text("Farveskemaer", 265, 200);
  
  drawColorschemeSelectionScheme(50, 300, "Light mode", #FFFFFF, #D9D9D9, #000000);
  drawColorschemeSelectionScheme(50, 450, "Dark mode", #000000, #D9D9D9, #FFFFFF);
  drawColorschemeSelectionScheme(50, 600, "Pink mode", #FFE1FD, #865280, #000000);
  drawColorschemeSelectionScheme(50, 750, "Blue mode", #DAFFFE, #5175AE, #000000);
  drawColorschemeSelectionScheme(50, 900, "Yellow mode", #FBFFDA, #896446, #000000);
}

void drawColorschemeSelectionScheme(int topLeftX, int topLeftY, String name, int colorBackgroundScheme, int colorDarkScheme, int colorTextScheme){
  noStroke();
  
  fill(#D9D9D9);
  rect(topLeftX, topLeftY, 160, 100);
  
  fill(#000000);
  textAlign(LEFT, CENTER);
  textSize(36);
  text(name, topLeftX+160, topLeftY+50);
  
  fill(colorBackgroundScheme);
  rect(topLeftX+10, topLeftY+10, 47, 80);
  
  fill(colorDarkScheme);
  rect(topLeftX+57, topLeftY+10, 46, 80);
  
  fill(colorTextScheme);
  rect(topLeftX+103, topLeftY+10, 47, 80);
  
  if(buttonClicked(topLeftX, topLeftY, 160, 100)){
    colorBackground = colorBackgroundScheme;
    colorDark = colorDarkScheme;
    colorText = colorTextScheme;
  }
}
