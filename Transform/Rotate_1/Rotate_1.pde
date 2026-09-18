/**
 * Rotate 1.
 *
 * Rotating simultaneously in the X and Y axis.
 * The mouse controls the rotation speed and rectangle size.
 */

float a = 0.0;
float rSize;

void setup() {
  size(800, 450, P3D);
  noStroke();
}

void draw() {
  
  // El fondo cambia según la posición del mouse
  float bg = map(mouseY, 0, height, 40, 160);
  background(bg);
  
  // El mouse controla la velocidad y dirección
  float speed = map(mouseX, 0, width, -0.03, 0.03);
  
  a += speed;
  
  if (a > TWO_PI) {
    a = 0.0;
  }
  
  if (a < -TWO_PI) {
    a = 0.0;
  }
  
  translate(width/2, height/2);
  
  // El tamaño cambia con el mouse
  rSize = map(mouseY, 0, height, 50, 160);
  
  // Primer rectángulo
  pushMatrix();
  rotateX(a);
  rotateY(a * 2.0);
  fill(255);
  rect(-rSize, -rSize, rSize*2, rSize*2);
  popMatrix();
  
  // Segundo rectángulo
  pushMatrix();
  rotateX(a * 1.5);
  rotateY(-a * 2.0);
  fill(0);
  rect(-rSize * 0.7, -rSize * 0.7, rSize * 1.4, rSize * 1.4);
  popMatrix();
}
