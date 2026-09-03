/**
 * Directional.
 *
 * El mouse define la direccion de la luz. Antes de iluminar la
 * escena, un campo de estelas cruza la pantalla siguiendo esa
 * misma direccion -como ver los propios rayos de luz viajando en
 * linea recta- y cambian de color segun la altura del mouse. Las
 * esferas muestran como esa luz responde al chocar con una
 * superficie real.
 */

void setup() {
  size(640, 360, P3D);
  noStroke();
  fill(204);
}

void draw() {
  background(10, 10, 20);

  float dirY = (mouseY / float(height) - 0.5) * 2;
  float dirX = (mouseX / float(width)  - 0.5) * 2;
  color sol = lerpColor(color(255, 150, 80), color(150, 190, 255), (dirY + 1) / 2);

  stroke(sol, 130);
  strokeWeight(2);
  for (int i = 0; i < 60; i++) {
    float rx = ((i * 97 - frameCount * 2.2 * dirX) % width  + width)  % width;
    float ry = ((i * 53 - frameCount * 2.2 * dirY) % height + height) % height;
    line(rx, ry, rx + dirX * 22, ry + dirY * 22);
  }
  noStroke();

  ambientLight(25, 25, 35);
  directionalLight(red(sol), green(sol), blue(sol), -dirX, -dirY, -1);

  translate(width/2 - 100, height/2, 0);
  sphere(80);
  translate(200, 0, 0);
  sphere(80);
}
