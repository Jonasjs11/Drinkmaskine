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
  return scrollbarCurrent - scrollAreaStart;
}

void resetScrollbar(){
  scrollbarCurrent = scrollAreaStart;
}

void updateScrollbarAreaAndView(int areaStart, int areaEnd, int viewSize){
  scrollAreaStart = areaStart;
  scrollAreaEnd = areaEnd;
  scrollViewSize = viewSize;
  
  scrollbarCurrent = min(max(scrollbarCurrent, scrollAreaStart), max(scrollAreaEnd - scrollViewSize, scrollAreaStart));
}

void drawScrollbar(int topRightX, int topRightY, int barWidth, boolean useServingScreenColors){
  if(scrollViewSize >= (scrollAreaEnd-scrollAreaStart)) { return; }
  
  noStroke();
  fill(useServingScreenColors ? colorDark : oldMoneyLight);
  rect(topRightX-barWidth, topRightY, barWidth, scrollViewSize);
  
  float percentOfAreaShown = scrollViewSize / (float)(scrollAreaEnd - scrollAreaStart);
  fill(useServingScreenColors ? colorText : oldMoneyText);
  rect(topRightX-barWidth+3, topRightY+(scrollbarCurrent-scrollAreaStart)*(percentOfAreaShown)+3, barWidth-6, scrollViewSize*percentOfAreaShown-6);
}
