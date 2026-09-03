PShape rocket;
float ry;
ArrayList<Star> stars;

public void setup() {
  size(640, 360, P3D);
  rocket = loadShape("rocket.obj");
  
  stars = new ArrayList<Star>();
  for (int i = 0; i < 300; i++) {
    stars.add(new Star());
  }
}

public void draw() {
  background(0);
  
  // Dibujar estrellas en movimiento
  pushMatrix();
  translate(width/2, height/2, 0);
  for (Star s : stars) {
    s.update();
    s.display();
  }
  popMatrix();
  
  // Dibujar cohete
  pushMatrix();
  translate(width/2, height/2 + 100, -200);
  rotateZ(PI);
  rotateY(ry);
  shape(rocket);
  popMatrix();
  
  ry += 0.02;
}

class Star {
  float x, y, z;
  float speed;
  
  Star() {
    x = random(-width, width);
    y = random(-height, height);
    z = random(0, 1000);
    speed = random(5, 20);
  }
  
  void update() {
    z -= speed;
    if (z < 0) {
      z = 1000;
      x = random(-width, width);
      y = random(-height, height);
    }
  }
  
  void display() {
    float sx = map(x / z, 0, 1, 0, width/2);
    float sy = map(y / z, 0, 1, 0, height/2);
    float r = map(z, 0, 1000, 2, 0);
    fill(255);
    noStroke();
    ellipse(sx, sy, r, r);
  }
}
