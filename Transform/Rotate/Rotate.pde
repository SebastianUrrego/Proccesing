/**
 * Rotate.
 * 
 * Rotating a square around the Z axis.
 * The rotation speed and size are controlled by the mouse.
 */

float angle;
float jitter;

void setup() {
  size(800, 450);
  noStroke();
  fill(255);
  rectMode(CENTER);
}

void draw() {

  // El fondo cambia según la posición vertical del mouse
  float bg = map(mouseY, 0, height, 20, 100);
  background(bg);

  // Durante los segundos pares se genera movimiento aleatorio
  if (second() % 2 == 0) {
    jitter = random(-0.1, 0.1);
  }

  // La velocidad depende de la posición horizontal del mouse
  float speed = map(mouseX, 0, width, -0.08, 0.08);

  angle = angle + speed + jitter;

  // Calculamos la rotación
  float c = cos(angle);

  translate(width/2, height/2);

  rotate(c);

  // El tamaño depende del mouseY
  float size = map(mouseY, 0, height, 80, 250);

  rect(0, 0, size, size);
}
