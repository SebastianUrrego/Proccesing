/**
 * Width and Height. 
 * 
 * The 'width' and 'height' variables contain the width and height 
 * of the display window as defined in the size() function. 
 */

void setup() {
  size(640, 360);
}

void draw() {
  background(0);
  noStroke();
  for (int i = 0; i < height; i += 20) {
    fill(255, 150, 0);  
    rect(0, i, width, 10);
    fill(255);
    rect(i, 0, 10, height);
  }
}
