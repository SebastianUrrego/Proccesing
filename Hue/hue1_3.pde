/**
 * Hue. 
 * 
 * Hue is the color reflected from or transmitted through an object 
 * and is typically referred to as the name of the color such as 
 * red, blue, or yellow. In this example, move the cursor vertically 
 * over each bar to alter its hue. 
 */
 
int barWidth = 20;
int lastBar = -1;

void setup() {
  size(600, 600);
  colorMode(HSB, height, height, height);  
  noStroke();
  background(1);
}

void draw() {
  int whichBar = mouseY / barWidth;
  if (whichBar != lastBar) {
    int barX = whichBar * barWidth;
    fill(height, height, mouseX);
    rect(barX, 1, barWidth, height);
    lastBar = whichBar;
  }
}
