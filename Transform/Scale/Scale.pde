/**
 * Scale
 *
 * Two squares change their size using scale().
 * The mouse controls the speed and size of the animation.
 */

float a = 0.0;
float s = 0.0;

void setup() {
  size(800, 450);
  noStroke();
  rectMode(CENTER);
  frameRate(30);
}

void draw() {
  
  // El fondo cambia según la posición vertical del mouse
  float bg = map(mouseY, 0, height, 40, 150);
  background(bg);
  
  // El mouse controla la velocidad
  float speed = map(mouseX, 0, width, 0.01, 0.08);
  
  a = a + speed;
  
  // La escala cambia entre un tamaño pequeño y grande
  s = abs(sin(a)) * 2.0 + 0.3;
  
  translate(width/2, height/2);
  
  // Primer cuadrado
  pushMatrix();
  scale(s);
  fill(51);
  rect(0, 0, 60, 60);
  popMatrix();
  
  // Segundo cuadrado
  pushMatrix();
  translate(150, 0);
  
  // El segundo cuadrado tiene una escala diferente
  float s2 = abs(cos(a * 1.5)) * 1.5 + 0.4;
  scale(s2);
  
  fill(255);
  rect(0, 0, 60, 60);
  popMatrix();
}
