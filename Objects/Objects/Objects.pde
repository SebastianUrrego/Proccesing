/**
 * Objects
 * by hbarragan.
 * 
 * Move the cursor across the image to change the speed and positions
 * of the geometry. The class MRect defines a group of lines.
 */

MRect r1, r2, r3, r4;

void setup()
{
  size(800, 450);

  fill(255, 204);
  noStroke();

  r1 = new MRect(4, 80.0, 0.25, 0.1*height, 15.0, 14.0);
  r2 = new MRect(6, 250.0, 0.18, 0.3*height, 10.0, 20.0);
  r3 = new MRect(3, 450.0, 0.35, 0.5*height, 20.0, 18.0);
  r4 = new MRect(8, 650.0, 0.15, 0.75*height, 8.0, 25.0);
}

void draw()
{
  background(0);

  // Dibujar los cuatro grupos
  r1.display();
  r2.display();
  r3.display();
  r4.display();

  // Cada grupo responde de una manera diferente

  // r1 sigue al mouse normalmente
  r1.move(mouseX, mouseY, 12);

  // r2 se mueve en dirección contraria
  r2.move(width - mouseX, height - mouseY, 20);

  // r3 sigue al mouse lentamente
  r3.move(mouseX * 0.5, mouseY, 35);

  // r4 utiliza el mouse invertido horizontalmente
  r4.move(width - mouseX, mouseY * 0.5, 50);


  // Cambiar la altura de cada grupo según el mouse

  r1.h = map(mouseX, 0, width, 0.15, 0.5);
  r2.h = map(mouseY, 0, height, 0.1, 0.4);
  r3.h = map(mouseX, 0, width, 0.2, 0.6);
  r4.h = map(mouseY, height, 0, 0.1, 0.5);
}


class MRect
{
  int w;
  float xpos;
  float h;
  float ypos;
  float d;
  float t;

  MRect(int iw, float ixp, float ih, float iyp, float id, float it) {
    w = iw;
    xpos = ixp;
    h = ih;
    ypos = iyp;
    d = id;
    t = it;
  }


  void move(float posX, float posY, float damping) {

    // Movimiento horizontal
    float dif = xpos - posX;

    if (abs(dif) > 1) {
      xpos -= dif/damping;
    }

    // Movimiento vertical
    dif = ypos - posY;

    if (abs(dif) > 1) {
      ypos -= dif/damping;
    }
  }


  void display() {

    // Crear las barras
    for (int i = 0; i < t; i++) {

      // Separación entre cada barra
      float x = xpos + (i * (d + w));

      // Efecto de onda
      float wave = sin(frameCount * 0.05 + i * 0.5) * 15;

      rect(
        x,
        ypos + wave,
        w,
        height * h
      );
    }
  }
}
