/**
 * Relativity: The Same Gray
 *
 * Un color se percibe en relación con sus vecinos. Cada cuadrito
 * pequeño de esta cuadrícula está pintado con exactamente el mismo
 * gris -- pero al estar rodeado de fondos de color distintos, cada
 * uno parece tener un brillo y una temperatura diferentes.
 * Presiona ESPACIO para quitar los fondos y comprobarlo.
 */

int cols = 8;
int rows = 5;
float cellW, cellH;
color sameGray;
boolean revealed = false;
float[] hueSeed;

void setup() {
  size(640, 360);
  colorMode(HSB, 360, 100, 100);
  noStroke();
  cellW = width / float(cols);
  cellH = height / float(rows);
  sameGray = color(0, 0, 55); // el mismo gris exacto, usado en todas partes

  hueSeed = new float[cols * rows];
  for (int i = 0; i < hueSeed.length; i++) {
    hueSeed[i] = random(360);
  }
}

void draw() {
  background(0, 0, 12);

  float t = millis() / 3000.0;

  for (int c = 0; c < cols; c++) {
    for (int r = 0; r < rows; r++) {
      int idx = c * rows + r;
      float x = c * cellW;
      float y = r * cellH;

      if (!revealed) {
        // el color de fondo deriva lentamente, único por celda
        float hue = (hueSeed[idx] + t * 15) % 360;
        fill(hue, 75, 65);
        rect(x, y, cellW, cellH);
      }

      // el cuadrito "mismo" gris, centrado en cada celda
      float pad = revealed ? cellW * 0.08 : cellW * 0.28;
      fill(sameGray);
      rect(x + pad, y + pad, cellW - pad * 2, cellH - pad * 2);
    }
  }

  fill(0, 0, 90);
  textAlign(CENTER);
  textSize(14);
  text(revealed ? "Sin contexto: es el mismo gris en todas partes"
                : "Todos los cuadros centrales son EXACTAMENTE el mismo color -- presiona ESPACIO",
       width / 2, height - 10);
}

void keyPressed() {
  if (key == ' ') {
    revealed = !revealed;
  }
}
