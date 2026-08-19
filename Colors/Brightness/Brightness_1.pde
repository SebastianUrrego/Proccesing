/**
 * Brightness
 * by Rusty Robison.
 *
 * Cambios realizados:
 * - Se modificó el ancho de las barras de 20 a 2 píxeles.
 * - Al hacer las barras más delgadas, ahora se muestran muchas más
 *   barras de colores en la pantalla.
 * - Se mantiene el funcionamiento original: mover el mouse
 *   verticalmente cambia el brillo de las barras.
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
  background(0);
}

void draw() {
  int whichBar = mouseX / barWidth;
  if (whichBar != lastBar) {
    int barX = whichBar * barWidth;
    fill(barX, 100, mouseY);
    rect(barX, 0, barWidth, height);
    lastBar = whichBar;
  }
}
