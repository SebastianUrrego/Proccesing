/**
 * Arm.
 * 
 * The angle of each segment is controlled with the mouseX and
 * mouseY position. The transformations applied to the segments
 * are also applied to the following segments because they are
 * inside the same pushMatrix() and popMatrix() group.
 */

float x, y;

float angle1 = 0.0;
float angle2 = 0.0;
float angle3 = 0.0;

float targetAngle1;
float targetAngle2;
float targetAngle3;

float segLength = 100;

void setup() {
  size(800, 450);

  strokeWeight(25);
  stroke(255, 160);

  x = width * 0.25;
  y = height * 0.5;
}

void draw() {
  background(15);

  // Cada segmento responde de forma diferente al mouse

  targetAngle1 = (mouseX / float(width) - 0.5) * -PI;

  targetAngle2 = (mouseY / float(height) - 0.5) * PI;

  // El tercer segmento se mueve en sentido contrario
  targetAngle3 = (mouseX / float(width) - 0.5) * PI;

  // Movimiento suave de cada articulación
  angle1 += (targetAngle1 - angle1) * 0.10;
  angle2 += (targetAngle2 - angle2) * 0.07;
  angle3 += (targetAngle3 - angle3) * 0.05;

  // El grosor depende de la posición vertical del mouse
  float thickness = map(mouseY, 0, height, 12, 35);
  strokeWeight(thickness);

  pushMatrix();

  // Primer segmento
  float length1 = map(mouseX, 0, width, 80, 150);
  segment(x, y, angle1, length1);

  // Segundo segmento
  float length2 = map(mouseY, 0, height, 60, 120);
  segment(length1, 0, angle2, length2);

  // Tercer segmento
  float length3 = map(mouseX, 0, width, 40, 100);
  segment(length2, 0, angle3, length3);

  popMatrix();
}


void segment(float x, float y, float a, float length) {
  translate(x, y);
  rotate(a);
  line(0, 0, length, 0);
}
