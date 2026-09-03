/**
 * Reflection — Luz en órbita
 *
 * Una esfera reflectante recibe una luz que gira alrededor de ella.
 * La posición horizontal del mouse controla la intensidad de la reflexión,
 * mientras que la luz en movimiento genera cambios constantes en el brillo.
 */

float angle = 0;

void setup() {
  size(640, 360, P3D);
  noStroke();
  colorMode(RGB, 1);
  fill(0.35);
}

void draw() {
  background(0.015);

  translate(width / 2, height / 2);

  // Luz ambiental suave
  ambientLight(0.08, 0.08, 0.1);

  // Luz principal que gira alrededor de la esfera
  float lx = cos(angle) * 300;
  float ly = sin(angle) * 180;
  float lz = 150;

  lightSpecular(1, 1, 1);
  pointLight(1, 0.85, 0.65, lx, ly, lz);

  // Segunda luz fría para aumentar el contraste
  directionalLight(0.15, 0.2, 0.4, -1, 0, -1);

  // El mouse controla qué tan reflectante es la superficie
  float reflection = mouseX / float(width);
  specular(reflection, reflection, reflection);
  shininess(20 + reflection * 100);

  // Esfera reflectante
  pushMatrix();
  rotateY(angle * 0.4);
  sphere(120);
  popMatrix();

  // Pequeño punto que representa la fuente de luz
  pushMatrix();
  translate(lx, ly, lz);
  emissive(1, 0.8, 0.5);
  sphere(10);
  popMatrix();

  angle += 0.015;
}
