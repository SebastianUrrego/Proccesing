/**
 * Clock — versión con movimiento elástico.
 *
 * El tiempo se sigue leyendo con second(), minute() y hour(),
 * pero en vez de saltar de golpe a la posición exacta, cada
 * aguja "persigue" su ángulo objetivo con una velocidad de
 * interpolación distinta, dando una sensación de inercia:
 * el segundero reacciona casi al instante, el horario se
 * desliza con calma.
 */

int cx, cy;
float secondsRadius;
float minutesRadius;
float hoursRadius;
float clockDiameter;

// Ángulos objetivo (los reales, según la hora)
float targetS, targetM, targetH;

// Ángulos que realmente se dibujan (van "persiguiendo" al objetivo)
float dispS, dispM, dispH;

// Qué tan rápido alcanza cada aguja su objetivo (0 = nunca, 1 = instantáneo)
float easeSeconds = 0.35;
float easeMinutes = 0.08;
float easeHours   = 0.015;

void setup() {
  size(640, 360);
  stroke(255);

  int radius = min(width, height) / 2;
  secondsRadius = radius * 0.72;
  minutesRadius = radius * 0.60;
  hoursRadius   = radius * 0.50;
  clockDiameter = radius * 1.8;

  cx = width / 2;
  cy = height / 2;

  // Arrancamos las agujas ya apuntando a la hora actual,
  // para que no hagan un barrido raro en el primer frame.
  dispS = targetS = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
  dispM = targetM = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;
  dispH = targetH = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;
}

void draw() {
  background(0);

  // Draw the clock background
  fill(80);
  noStroke();
  ellipse(cx, cy, clockDiameter, clockDiameter);

  // Angles for sin() and cos() start at 3 o'clock;
  // subtract HALF_PI to make them start at the top
  targetS = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
  targetM = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;
  targetH = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;

  // En vez de saltar directo al ángulo objetivo, cada aguja
  // se acerca un poco por frame (interpolación angular con
  // el camino más corto), lo que le da a cada una su propio
  // "carácter" de movimiento.
  dispS = lerpAngle(dispS, targetS, easeSeconds);
  dispM = lerpAngle(dispM, targetM, easeMinutes);
  dispH = lerpAngle(dispH, targetH, easeHours);

  // Draw the hands of the clock
  stroke(255);
  strokeWeight(1);
  line(cx, cy, cx + cos(dispS) * secondsRadius, cy + sin(dispS) * secondsRadius);
  strokeWeight(2);
  line(cx, cy, cx + cos(dispM) * minutesRadius, cy + sin(dispM) * minutesRadius);
  strokeWeight(4);
  line(cx, cy, cx + cos(dispH) * hoursRadius, cy + sin(dispH) * hoursRadius);

  // Draw the minute ticks
  strokeWeight(2);
  beginShape(POINTS);
  for (int a = 0; a < 360; a += 6) {
    float angle = radians(a);
    float x = cx + cos(angle) * secondsRadius;
    float y = cy + sin(angle) * secondsRadius;
    vertex(x, y);
  }
  endShape();
}

// Interpola entre dos ángulos tomando siempre el camino más corto
// (evita que una aguja gire "la vuelta larga" al cruzar 0°/360°).
float lerpAngle(float current, float target, float amt) {
  float diff = target - current;
  while (diff > PI)  diff -= TWO_PI;
  while (diff < -PI) diff += TWO_PI;
  return current + diff * amt;
}
