  class Bottle{
  String name;
  float alcoholPercentage;
  PImage icon;
  String iconPath;
  
  Bottle(String name, float alcoholPercentage, PImage icon, String iconPath){
    this.name = name;
    this.alcoholPercentage = alcoholPercentage;
    this.icon = icon;
    this.iconPath = iconPath;
  }
  
  boolean isAlchoholFree(){
    return alcoholPercentage == 0;
  }
  
  void showIcon(int centerX, int centerY, int imgWidth, int imgHeight){
    if(icon == null){
      fill(255);
      rect(centerX-imgWidth/2, centerY-imgHeight/2, imgWidth, imgHeight);
      
      textAlign(CENTER, CENTER);
      fill(0);
      textSize(imgHeight/2);
      text("?", centerX, centerY);
      return;
    }
    
    imageMode(CENTER);
    image(icon, centerX,  centerY, imgWidth, imgHeight);
  }
}
