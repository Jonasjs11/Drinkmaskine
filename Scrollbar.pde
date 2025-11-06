int scrollAreaYStart;
int scrollAreaYEnd;
int scrollViewHeight;
int scrollbarCurrent;
int scrollbarSensitivity = 100;

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  scrollbarCurrent += e * scrollbarSensitivity;
  scrollbarCurrent = min(max(scrollbarCurrent, scrollAreaYStart), scrollAreaYEnd - scrollViewHeight);
}

int getScrollViewOffset(){
  return scrollbarCurrent - scrollAreaYStart;
}

void updateScrollbarToView(int areaYStart, int areaYEnd, int viewHeight){
  scrollAreaYStart = areaYStart;
  scrollAreaYEnd = areaYEnd;
  scrollViewHeight = viewHeight;
  scrollbarCurrent = areaYStart;
}

void drawScrollbar(int topRightX, int topRightY, int barWidth){
  noStroke();
  fill(oldMoneyLight);
  rect(topRightX-barWidth, topRightY, barWidth, scrollViewHeight);
  
  float percentOfAreaShown = scrollViewHeight / (scrollAreaYEnd - scrollAreaYStart);
  //rect(, , , );
}
