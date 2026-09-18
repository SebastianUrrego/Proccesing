/**
 * Rotate Push Pop.
 * 
 * The push() and pop() functions allow for more control over transformations.
 * Each box has its own rotation and size controlled by the mouse.
 */

float a;                         // Angle of rotation
float offset = PI/18.0;          // Angle offset between boxes
int num = 12;                    // Number of boxes

void setup() {
  size(800, 450, P3D);
  noStroke();
}


void draw() {

  lights();

  // El fondo cambia según la posición del mouse
  float bg = map(mouseY, 0, height, 10, 60);
  background(0, 0, bg);

  translate(width/2, height/2);

  // La velocidad cambia según mouseX
  float speed = map(mouseX, 0, width, -0.03, 0.03);

  for (int i = 0; i < num; i++) {

    float gray = map(i, 0, num-1, 40, 255);

    pushMatrix();

    fill(gray);

    // Cada caja tiene una rotación diferente
    rotateY(a + offset * i);

    // Movimiento contrario para algunas cajas
    if (i % 2 == 0) {
      rotateX(a/2 + offset * i);
    } else {
      rotateX(-a/2 - offset * i);
    }

    // Tamaño diferente para cada caja
    float boxSize = map(i, 0, num-1, 80, 220);

    box(boxSize);

    popMatrix();
  }

  // Rotación general controlada por el mouse
  a += speed;
}
