/**
 * Spotlight — Luz de Vigilancia
 *
 * Un foco azul recorre la esfera como un reflector.
 * El mouse controla la altura y la apertura del foco.
 */

float angle = 0;

void setup() {
  size(640, 360, P3D);
  noStroke();
  sphereDetail(60);
}

void draw() {
  background(3, 5, 12);

  // Luz ambiental tenue
  ambientLight(15, 20, 35);

  // Luz superior que revela la forma de la esfera
  directionalLight(40, 50, 70, 0, -1, 0);

  // Movimiento circular del foco alrededor de la esfera
  angle += 0.015;

  float x = 360 + cos(angle) * 280;
  float z = 600 + sin(angle) * 180;

  // Apertura controlada por el mouse
  float cone = map(mouseX, 0, width, PI/8, PI/2);

  // Foco azul de vigilancia
  spotLight(
    60, 140, 255,
    x, mouseY, z,
    0, 0, -1,
    cone, 500
  );

  // Pequeño foco secundario que simula reflejo
  spotLight(
    20, 60, 140,
    360, 80, 500,
    0, 0, -1,
    PI/3, 300
  );

  translate(width/2, height/2, 0);

  // Esfera que recibe la iluminación
  fill(180);
  sphere(120);
}
