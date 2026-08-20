/**
 * Logical Operators — Saturación en movimiento
 *
 * Mismo concepto que el sketch original (AND, OR, NOT), pero en vez de
 * líneas fijas horizontales se dibujan anillos concéntricos animados
 * cuya SATURACIÓN (modo de color HSB) cambia según cada condición lógica.
 *
 * - Zona AND  -> alta saturación, colores vívidos, se mueve con el tiempo
 * - Zona OR   -> baja saturación, casi en escala de grises
 * - test true -> puntos saturados girando en un sentido
 * - test false -> puntos blancos (sin saturación) girando en sentido contrario
 */

int rings = 140;
float maxRadius;

void setup() {
  size(640, 360);
  colorMode(HSB, 360, 100, 100);
  maxRadius = dist(0, 0, width/2, height/2);
}

void draw() {
  background(210, 20, 10); // fondo azul muy oscuro, casi sin saturación

  boolean test = false;

  // El centro de la "ventana AND" se desplaza con el tiempo
  float center = rings/2.0 + sin(frameCount * 0.02) * rings * 0.25;
  float lowerBound = center - rings * 0.15;
  float upperBound = center + rings * 0.15;

  for (int i = 0; i <= rings; i += 2) {
    float r = map(i, 0, rings, 10, maxRadius);
    float hue = map(i, 0, rings, 0, 360);

    // Logical AND: alta saturación, colores vívidos
    if ((i > lowerBound) && (i < upperBound)) {
      test = false;
      noFill();
      strokeWeight(2);
      stroke(hue, 95, 95);
      ellipse(width/2, height/2, r * 2, r * 2);
    }

    // Logical OR: baja saturación, casi grises
    if ((i <= lowerBound) || (i >= upperBound)) {
      test = true;
      noFill();
      strokeWeight(1);
      stroke(hue, 10, 70);
      ellipse(width/2, height/2, r * 2, r * 2);
    }

    // Testing if a boolean value is "true" -> puntos saturados girando
    if (test) {
      noStroke();
      fill(hue, 100, 100);
      float x = width/2 + cos(radians(hue + frameCount)) * r;
      float y = height/2 + sin(radians(hue + frameCount)) * r;
      ellipse(x, y, 4, 4);
    }

    // Testing if a boolean value is "false" -> puntos blancos sin saturación
    if (!test) {
      noStroke();
      fill(0, 0, 100);
      float x = width/2 + cos(radians(hue - frameCount)) * r;
      float y = height/2 + sin(radians(hue - frameCount)) * r;
      ellipse(x, y, 3, 3);
    }
  }
}
