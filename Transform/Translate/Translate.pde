 /**
  * Translate.
  *
  * The translate() function moves objects around the window.
  * The mouse controls the speed, position and size of the squares.
  */

float x, y;
float dim = 80.0;

void setup() {
  size(800, 450);
  noStroke();
}

void draw() {
  background(102);
  
  // La velocidad depende del mouse
  float speed = map(mouseY, 0, height, 0.3, 3.0);
  
  x = x + speed;
  
  if (x > width + dim) {
    x = -dim;
  }
  
  // El tamaño cambia según la posición horizontal del mouse
  dim = map(mouseX, 0, width, 40, 120);
  
  // Posición vertical controlada por el mouse
  float vertical = map(mouseY, 0, height, 80, height - 80);
  
  // Primer cuadrado
  translate(x, vertical);
  fill(255);
  rect(-dim/2, -dim/2, dim, dim);
  
  // El segundo translate se acumula con el primero,
  // por eso este cuadrado se mueve el doble en X.
  translate(x, dim);
  fill(0);
  rect(-dim/2, -dim/2, dim, dim);
}
