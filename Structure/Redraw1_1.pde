float y,x;
boolean auto = false;

void setup() {
  size(640, 360);
  stroke(255);
  noLoop();
  y = height * 0.5;
  x = 0;
}

void draw() {
  background(0);
  y = y - 4;
  x = x + 20;
  if (x > width) { x = 0; }
  line(x, 0, x, height);   
  if (y < 0) { y = height; }
  line(0, y, width, y);

  fill(255);
  text(auto ? "Modo: AUTOMÁTICO" : "Modo: POR CLIC", 20, 30);
}

void mousePressed() {
  auto = !auto;          // cambia el modo
  if (auto) {
    loop();              // draw() empieza a ejecutarse solo
  } else {
    noLoop();            // draw() se detiene
    redraw();            // dibuja una vez para actualizar el texto
  }
}
