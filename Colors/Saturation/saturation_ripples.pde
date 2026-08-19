/**
 * Saturation Ripples
 *
 * La saturación es la pureza de un color: cuánto gris tiene mezclado
 * el tono (hue). Aquí la saturación se propaga como ondas concéntricas
 * desde el cursor, mientras el tono va derivando lentamente con el
 * tiempo. Mueve el cursor para enviar olas de saturación por el lienzo;
 * incluso quieto, la escena sigue respirando.
 */

int cellSize = 16;

void setup() {
  size(640, 360);
  colorMode(HSB, 360, 100, 100);
  noStroke();
  ellipseMode(CENTER);
}

void draw() {
  background(0, 0, 8); // fondo casi negro, baja saturación y brillo

  float t = millis() / 1000.0;

  for (int x = 0; x < width; x += cellSize) {
    for (int y = 0; y < height; y += cellSize) {

      float cx = x + cellSize / 2.0;
      float cy = y + cellSize / 2.0;

      // distancia al cursor: genera una onda que se expande
      float d = dist(cx, cy, mouseX, mouseY);
      float ripple = sin(d * 0.05 - t * 4.0);            // onda viajera
      float falloff = constrain(1.0 - d / 380.0, 0, 1);  // se atenúa con la distancia

      float sat = 50 + ripple * 50 * falloff;             // la saturación pulsa
      sat = constrain(sat, 0, 100);

      float hue = (x * 0.4 + y * 0.2 + t * 20) % 360;      // el tono se desliza en diagonal
      float bri = 70 + 20 * falloff;                       // más brillo cerca del cursor

      fill(hue, sat, bri);

      float sizeMod = cellSize * (0.5 + 0.5 * falloff);    // los círculos crecen cerca del cursor
      ellipse(cx, cy, sizeMod, sizeMod);
    }
  }
}
