/**
 * Mixture Grid
 * Tres luces (naranja, azul y amarilla) se mezclan sobre una grilla
 * de cajas que "respira" y gira siguiendo al mouse.
 * Basado en el ejemplo de Simon Greenwold.
 */

float t = 0;

void setup() {
  size(640, 360, P3D);
  noStroke();
}

void draw() {
  background(8);
  t += 0.02;
  defineLights();

  int spacing = 60;
  for (int x = 0; x <= width; x += spacing) {
    for (int y = 0; y <= height; y += spacing) {
      pushMatrix();
      // Profundidad ondulante por celda
      translate(x, y, sin(t + x * 0.02 + y * 0.02) * 20);

      // Rotación con el mouse + deriva propia
      rotateY(map(mouseX, 0, width, 0, PI) + t * 0.3);
      rotateX(map(mouseY, 0, height, 0, PI) + t * 0.2);

      // Tamaño pulsante para reforzar la mezcla de luces
      float sz = 60 + 30 * sin(t + x * 0.03) * cos(t + y * 0.03);
      ambient(180);
      specular(255);
      shininess(8);
      box(sz);
      popMatrix();
    }
  }
}

void defineLights() {
  // Luz puntual naranja orbitando por la derecha
  float lx = 200 + cos(t) * 60;
  float lz = cos(t) * 100;
  pointLight(255, 140, 0,
             lx, -150, lz);

  // Luz direccional azul constante desde la izquierda
  directionalLight(0, 102, 255,
                    1, 0.2, 0);

  // Foco amarillo que apunta hacia donde está el mouse
  float dirX = map(mouseX, 0, width, -1, 1);
  float dirY = map(mouseY, 0, height, -1, 1);
  spotLight(255, 255, 109,
            width / 2, height / 2, 220,
            dirX, dirY, -1,
            PI / 2.2, 3);
}
