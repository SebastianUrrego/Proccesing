void setup() {
  size(640, 360, P3D);
}

void draw() {
  background(0);
  lights();
  noStroke();

  // Cubo que rota en Y
  fill(255, 100, 0);
  pushMatrix();
  translate(130, height/2, 0);
  rotateY(frameCount * 0.02); // Rotación continua
  rotateX(-0.4);
  box(100);
  popMatrix();

  // Esfera que rota en X
  noFill();
  stroke(255);
  pushMatrix();
  translate(500, height*0.35, -200);
  rotateX(frameCount * 0.01);
  sphere(280);
  popMatrix();
}
