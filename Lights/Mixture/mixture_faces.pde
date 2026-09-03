/**
 * Mixture — Filtros de color sobre iluminación
 * Basado en el ejemplo original de Simon Greenwold.
 *
 * El sketch muestra una caja 3D iluminada por tres tipos de luz:
 * puntual, direccional y foco (spot).
 *
 * Cada una de las seis caras tiene un filtro de color diferente,
 * haciendo que la misma iluminación produzca distintos resultados
 * visuales según la superficie.
 */

float s = 75;

// Controla el estado de cada fuente de luz.
boolean usePoint = true, useDir = true, useSpot = true;

void setup() {
  // Configura una escena tridimensional.
  size(640, 360, P3D);
  noStroke();
}

void draw() {
  background(10);

  // Centra el objeto en la ventana.
  translate(width / 2, height / 2);

  // Luz puntual en movimiento.
  if (usePoint) {
    pointLight(
      150 + 80 * sin(frameCount * 0.02), 100, 0,
      200 * cos(frameCount * 0.015), -150,
      200 * sin(frameCount * 0.015)
    );
  }

  // Luz direccional azul cuya dirección cambia con el tiempo.
  if (useDir) {
    directionalLight(
      0, 102, 255,
      sin(frameCount * 0.01), 0.3,
      cos(frameCount * 0.01)
    );
  }

  // Foco amarillo dirigido hacia el objeto.
  if (useSpot) {
    spotLight(
      255, 255, 109,
      0, 40, 200,
      0, -0.5, -0.5,
      PI / 2, 2
    );
  }

  // Permite observar el objeto desde diferentes ángulos.
  rotateY(map(mouseX, 0, width, 0, PI));
  rotateX(map(mouseY, 0, height, 0, PI));

  // Cada cara representa un filtro de color diferente.
  face(0, 0,        255, 255, 255); // Blanco
  face(PI, 0,        25,  25,  25); // Oscuro
  face(HALF_PI, 0,   255,  50,  50); // Rojo
  face(-HALF_PI, 0,   50,  90, 255); // Azul
  face(0, -HALF_PI,   255, 255,  50); // Amarillo
  face(0, HALF_PI,     50, 255,  90); // Verde
}

// Construye una cara de la caja y le asigna su color.
void face(float ry, float rx, float r, float g, float b) {
  pushMatrix();

  // Orienta la cara y la coloca en el exterior de la caja.
  rotateY(ry);
  rotateX(rx);
  translate(0, 0, s);

  // Aplica el color correspondiente al filtro.
  fill(r, g, b);

  // Construye la cara como un cuadrado de cuatro vértices.
  beginShape(QUADS);
  vertex(-s, -s, 0);
  vertex(s, -s, 0);
  vertex(s, s, 0);
  vertex(-s, s, 0);
  endShape(CLOSE);

  popMatrix();
}
