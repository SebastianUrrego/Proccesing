/**
 * Multiple constructors
 * 
 * A class can have multiple constructors that assign the fields in different ways. 
 * Sometimes it's beneficial to specify every aspect of an object's data by assigning 
 * parameters to the fields, but other times it might be appropriate to define only 
 * one or a few.
 */

Spot sp1, sp2;

void setup() {
  size(640, 360);

  // Sol: constructor sin parámetros
  sp1 = new Spot();

  // Luna: constructor con tres parámetros
  sp2 = new Spot(width + 90, height * 0.5, 90);
}

void draw() {

  // Distancia entre el Sol y la Luna
  float distance = abs(sp1.x - sp2.x);

  // El cielo se oscurece cuando la Luna se acerca al Sol
  if (distance < 250) {
    background(25, 30, 55);

    // Estrellas durante el eclipse
    fill(255);
    noStroke();

    ellipse(80, 70, 3, 3);
    ellipse(150, 120, 4, 4);
    ellipse(250, 60, 3, 3);
    ellipse(390, 90, 4, 4);
    ellipse(500, 55, 3, 3);
    ellipse(570, 130, 4, 4);
    ellipse(100, 270, 3, 3);
    ellipse(520, 280, 3, 3);

  } else {
    // Cielo normal
    background(135, 190, 230);
  }

  // El Sol se mueve lentamente hacia la derecha
  sp1.moveRight(0.5);

  // La Luna se mueve rápidamente hacia la izquierda
  sp2.moveLeft(2.5);

  sp1.display();
  sp2.display();

  // Reiniciar el Sol cuando salga de la pantalla
  if (sp1.x > width + sp1.radius) {
    sp1.x = -sp1.radius;
  }

  // Reiniciar la Luna cuando salga de la pantalla
  if (sp2.x < -sp2.radius) {
    sp2.x = width + sp2.radius;
  }
}


class Spot {
  float x, y, radius;

  // Primer constructor
  // Se utiliza para crear el Sol
  Spot() {
    radius = 120;
    x = -radius;
    y = height * 0.5;
  }

  // Segundo constructor
  // Se utiliza para crear la Luna
  Spot(float xpos, float ypos, float r) {
    x = xpos;
    y = ypos;
    radius = r;
  }

  // Movimiento hacia la derecha
  void moveRight(float speed) {
    x += speed;
  }

  // Movimiento hacia la izquierda
  void moveLeft(float speed) {
    x -= speed;
  }

  void display() {

    // Sol
    if (radius == 120) {
      noStroke();
      fill(255, 190, 40);
      ellipse(x, y, radius * 2, radius * 2);
    }

    // Luna
    else {
      noStroke();
      fill(20);
      ellipse(x, y, radius * 2, radius * 2);
    }
  }
}
