/**
 * Loading URLs
 *
 * Dos botones, cada uno abre una página distinta en el navegador.
 * Al pasar el mouse por encima, el botón se ilumina y crece un poco;
 * al hacer clic, se abre el link correspondiente.
 */

String urlRoblox = "https://www.roblox.com/es/home";
String urlKlipy  = "https://klipy.com/gifs/gunna-fire";

boolean overButton1 = false;
boolean overButton2 = false;

float scale1 = 1.0;
float scale2 = 1.0;

int bx1 = 90,  by1 = 130, bw1 = 180, bh1 = 120;
int bx2 = 370, by2 = 130, bw2 = 180, bh2 = 120;

color robloxBase  = color(20, 20, 20);
color robloxHover = color(220, 20, 20);
color klipyBase   = color(150, 40, 200);
color klipyHover  = color(255, 90, 180);

void setup() {
  size(640, 360);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(30);

  // animación suave al pasar el mouse
  scale1 = lerp(scale1, overButton1 ? 1.08 : 1.0, 0.15);
  scale2 = lerp(scale2, overButton2 ? 1.08 : 1.0, 0.15);

  drawTitle();
  drawRobloxButton();
  drawKlipyButton();
}

void drawTitle() {
  fill(240);
  textSize(18);
  text("Elige a dónde ir", width / 2, 40);

  textSize(12);
  fill(160);
  text("Pasa el mouse sobre un botón y haz clic para abrir el link", width / 2, 64);
}

void drawRobloxButton() {
  float cx = bx1 + bw1 / 2.0;
  float cy = by1 + bh1 / 2.0;

  pushMatrix();
  translate(cx, cy);
  scale(scale1);
  translate(-cx, -cy);

  stroke(255);
  strokeWeight(2);
  fill(overButton1 ? robloxHover : robloxBase);
  rect(bx1, by1, bw1, bh1, 16);

  // icono tipo "control de juego"
  noStroke();
  fill(255);
  rectMode(CENTER);
  rect(cx, cy - 12, 74, 30, 12);
  rectMode(CORNER);
  fill(overButton1 ? robloxHover : robloxBase);
  ellipse(cx - 18, cy - 12, 14, 14);
  ellipse(cx + 18, cy - 12, 14, 14);

  fill(255);
  textSize(14);
  text("ROBLOX", cx, by1 + bh1 - 18);

  popMatrix();
}

void drawKlipyButton() {
  float cx = bx2 + bw2 / 2.0;
  float cy = by2 + bh2 / 2.0;

  pushMatrix();
  translate(cx, cy);
  scale(scale2);
  translate(-cx, -cy);

  stroke(255);
  strokeWeight(2);
  fill(overButton2 ? klipyHover : klipyBase);
  rect(bx2, by2, bw2, bh2, 16);

  // icono tipo "play" (gif/video)
  noStroke();
  fill(255);
  triangle(cx - 14, cy - 26, cx - 14, cy + 2, cx + 16, cy - 12);

  fill(255);
  textSize(14);
  text("KLIPY GIF", cx, by2 + bh2 - 18);

  popMatrix();
}

void mousePressed() {
  if (overButton1) {
    link(urlRoblox);
  } else if (overButton2) {
    link(urlKlipy);
  }
}

void mouseMoved() {
  checkButtons();
}

void mouseDragged() {
  checkButtons();
}

void checkButtons() {
  overButton1 = (mouseX > bx1 && mouseX < bx1 + bw1 && mouseY > by1 && mouseY < by1 + bh1);
  overButton2 = (mouseX > bx2 && mouseX < bx2 + bw2 && mouseY > by2 && mouseY < by2 + bh2);
}
