/**
 * Inheritance
 * 
 * A class can be defined using another class as a foundation. In object-oriented
 * programming terminology, one class can inherit fields and methods from another.
 * An object that inherits from another is called a subclass, and the object it
 * inherits from is called a superclass. A subclass extends the superclass.
 */

SpinSpots spots;
SpinArm arm;

void setup() {
  size(800, 450);

  // Línea larga
  arm = new SpinArm(width/2, height/2, 0.015);

  // Líneas cortas
  spots = new SpinSpots(width/2, height/2, 0.008, 120.0);
}

void draw() {
  background(204);

  arm.update();
  arm.display();

  spots.update();
  spots.display();
}


class Spin {
  float x, y, speed;
  float angle = 0.0;

  Spin(float xpos, float ypos, float s) {
    x = xpos;
    y = ypos;
    speed = s;
  }

  void update() {
    angle += speed;
  }
}


class SpinArm extends Spin {

  SpinArm(float x, float y, float s) {
    super(x, y, s);
  }

  void display() {
    strokeWeight(4);
    stroke(0);

    pushMatrix();
    translate(x, y);

    rotate(angle);

    // Línea larga
    line(0, 0, 220, 0);

    popMatrix();
  }
}


class SpinSpots extends Spin {
  float dim;

  SpinSpots(float x, float y, float s, float d) {
    super(x, y, s);
    dim = d;
  }

  void display() {
    strokeWeight(4);
    stroke(0);

    // Línea larga de las spots
    pushMatrix();
    translate(x, y);

    // Gira en la dirección normal
    rotate(angle);

    line(0, 0, dim, 0);

    popMatrix();


    // Línea corta
    pushMatrix();
    translate(x, y);

    // Gira en dirección contraria
    rotate(-angle);

    line(0, 0, dim * 0.5, 0);

    popMatrix();
  }
}
