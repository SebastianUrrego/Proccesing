/**
 * Ojos interactivos
 *
 * Los ojos siguen al mouse.
 * El color del iris cambia según la posición del mouse.
 */

Eye e1, e2, e3;

void setup() {
  size(640, 360);

  noStroke();

  colorMode(HSB, 360, 100, 100);

  e1 = new Eye(250, 100, 120);
  e2 = new Eye(150, 230, 80);
  e3 = new Eye(450, 220, 150);
}

void draw() {

  // Fondo
  background(230, 30, 15);

  // Actualizar ojos
  e1.update(mouseX, mouseY);
  e2.update(mouseX, mouseY);
  e3.update(mouseX, mouseY);

  // Dibujar ojos
  e1.display();
  e2.display();
  e3.display();
}


class Eye {

  int x, y;
  int size;

  float angle = 0.0;

  Eye(int tx, int ty, int ts) {
    x = tx;
    y = ty;
    size = ts;
  }

  void update(int mx, int my) {

    // Calcular dirección hacia el mouse
    angle = atan2(my - y, mx - x);
  }

  void display() {

    pushMatrix();

    translate(x, y);

    // Parte blanca del ojo
    fill(0, 0, 100);
    ellipse(0, 0, size, size);

    // Rotar hacia el mouse
    rotate(angle);

    // Color del iris según la posición del mouse
    float colorIris = map(mouseX, 0, width, 0, 360);

    fill(colorIris, 90, 90);
    ellipse(size/4, 0, size/2, size/2);

    // Pupila
    fill(0, 0, 5);
    ellipse(size/4, 0, size/4, size/4);

    // Brillo
    fill(0, 0, 100);
    ellipse(size/4 - size/16, -size/16, size/10, size/10);

    popMatrix();
  }
}
