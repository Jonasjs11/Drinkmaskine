void drawDrinksScreen(){
  background(255);
  
  //NEDENUNDER ER BARE FOR TEST, SLET DET GERNE
  fill(#D9D9D9);
  ellipse(100, 100, 100, 100);
  allDrinks.get(0).showIcon(100, 100, 100, 100);
  ellipse(300, 150, 200, 200);
  allDrinks.get(0).showIcon(300, 150, 200, 200);
  ellipse(600, 100, 200, 100);
  allDrinks.get(0).showIcon(600, 100, 200, 100);
  ellipse(900, 150, 100, 200);
  allDrinks.get(0).showIcon(900, 150, 100, 200);
   image(oldMoneyKnap,1680, 59);
   
   
     if (mousePressed &&
      mouseX >= 1680 && mouseX <= 1780 &&
      mouseY >= 4 && mouseY <= 104) {
    switchToScreenMainMenu();
  }
}
