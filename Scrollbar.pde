int scrollAreaStart;
int scrollAreaEnd;
int scrollViewSize;
int scrollbarCurrent;
int scrollbarSensitivity = 100;

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  scrollbarCurrent += e * scrollbarSensitivity;
  scrollbarCurrent = min(max(scrollbarCurrent, scrollAreaStart), max(scrollAreaEnd - scrollViewSize, scrollAreaStart));
}

int getScrollViewOffset(){
  println(scrollbarCurrent);
  return scrollbarCurrent - scrollAreaStart;
}

void resetScrollbar(){
  scrollbarCurrent = scrollAreaStart;
}

void updateScrollbarToView(int areaStart, int areaEnd, int viewSize){
  scrollAreaStart = areaStart;
  scrollAreaEnd = areaEnd;
  scrollViewSize = viewSize;
}

void drawScrollbar(int topRightX, int topRightY, int barWidth, boolean useServingScreenColors){
  if(scrollViewSize >= (scrollAreaEnd-scrollAreaStart)) { return; }
  
  noStroke();
  fill(useServingScreenColors ? colorDark : oldMoneyLight);
  rect(topRightX-barWidth, topRightY, barWidth, scrollViewSize);
  
  float percentOfAreaShown = scrollViewSize / (float)(scrollAreaEnd - scrollAreaStart);
  fill(useServingScreenColors ? colorText : oldMoneyText);
  rect(topRightX-barWidth, topRightY+(scrollbarCurrent-scrollAreaStart)*(percentOfAreaShown), barWidth, scrollViewSize*percentOfAreaShown);
}
