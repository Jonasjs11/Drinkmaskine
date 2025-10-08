class Bottle{
  String name;
  float alcoholPercentage;
  
  Bottle(String name, float alcoholPercentage){
    this.name = name;
    this.alcoholPercentage = alcoholPercentage;
  }
  
  boolean isAlchoholFree(){
    return alcoholPercentage == 0;
  }
}
