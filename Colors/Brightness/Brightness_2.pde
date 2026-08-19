/**
 * Brightness
 * by Rusty Robison.
 *
 * Cambios realizados:
 * - Se cambió el fondo de negro a blanco usando background(255).
 * - Se redujo la saturación de 100 a 50 y se invirtió el brillo
 *   utilizando height - mouseY.
 *
 * Brightness is the relative lightness or darkness of a color.
 * Move the cursor vertically over each bar to alter its brightness.
 */

int barWidth = 2;
int lastBar = -1;

void setup() {
  size(640, 360);
  colorMode(HSB, width, 100, height);
  noStroke();
  background(255);
}

void draw() {
  int whichBar = mouseX / barWidth;
  if (whichBar != lastBar) {
    int barX = whichBar * barWidth;
    fill(barX, 50, height - mouseY);
    rect(barX, 0, barWidth, height);
    lastBar = whichBar;
  }
}
