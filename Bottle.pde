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
    imageMode(CENTER);
    image(icon, centerX,  centerY, imgWidth, imgHeight);
  }
}
