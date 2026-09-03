/**
 * Luces, Encendido/Apagado — Reimaginado.
 * Haz clic para cambiar entre cinco estados: oscuridad, iluminación
 * ambiental, un sol direccional en movimiento, una luz puntual que orbita
 * y un foco de luz que se desplaza.
 */

int mode = 0;
float spin = 0.0;
color[] bg = { color(5), color(40,30,20), color(10,10,30), color(15), color(8) };
String[] label = {"APAGADO", "AMBIENTE", "DIRECCIONAL", "PUNTUAL", "FOCO"};

void setup() {
  size(640, 360, P3D);
  noStroke();
  sphereDetail(24);
  textAlign(CENTER, TOP);
}

void draw() {
  background(bg[mode]);
  spin += 0.012;
  float lx = width/2 + cos(spin*2)*220;
  float ly = height/2 + sin(spin*2)*100;
  float lz = 150;

  pushMatrix();
  translate(width/2, height/2, 0);

  if (mode == 1) ambientLight(120, 90, 60);
  else if (mode == 2) {
    directionalLight(255, 240, 200, cos(spin), 0.5, sin(spin));
    ambientLight(15, 15, 20);
  } else if (mode == 3) {
    pointLight(255, 80, 180, lx - width/2, ly - height/2, lz);
    ambientLight(10, 10, 15);
  } else if (mode == 4) {
    spotLight(255, 255, 255, 0, 0, 300, 0, 0, -1, PI/6, 2);
    ambientLight(8, 8, 8);
  }

  rotateX(PI/9);
  rotateY(PI/5 + spin);

  pushMatrix();
  translate(-90, 0, 0);
  box(110);
  popMatrix();

  pushMatrix();
  translate(90, 0, 0);
  sphere(65);
  popMatrix();
  popMatrix();

  if (mode == 3) {
    pushMatrix();
    translate(lx, ly, lz);
    emissive(255, 80, 180);
    sphere(8);
    popMatrix();
  }

  noLights();
  fill(255);
  text(label[mode] + "  (haz clic para cambiar)", width/2, 10);
}

void mousePressed() {
  mode = (mode + 1) % label.length;
}
