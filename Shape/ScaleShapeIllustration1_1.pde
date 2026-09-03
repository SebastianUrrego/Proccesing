/**
 * Scale Shape - Zoom, Rotación y Color
 * MouseX: Controla el zoom
 * MouseY: Controla la rotación
 * Clic: Cambia colores
 */

PShape bot;
float zoom, rotacion;
color colorFondo = 102;
color colorBorde = 255;

void setup() {
  size(640, 360);
  bot = loadShape("bot1.svg");
} 

void draw() {
  background(colorFondo);
  
  // === TRANSFORMACIONES ===
  translate(width/2, height/2);
  
  // Zoom controlado por mouseX
  zoom = map(mouseX, 0, width, 0.1, 4.5);
  scale(zoom);
  
  // Rotación controlada por mouseY
  rotacion = map(mouseY, 0, height, -PI, PI);
  rotate(rotacion);
  
  // Dibuja el robot
  shape(bot, -140, -140);
  
  // === INTERFAZ GRÁFICA ===
  
  // Marco decorativo
  noFill();
  stroke(colorBorde, 150);
  strokeWeight(2);
  rect(-150, -150, 300, 300);
  
  // === INFORMACIÓN EN PANTALLA ===
  resetMatrix(); // Reinicia las transformaciones para el texto
  
  // Panel de información
  fill(0, 0, 0, 180);
  noStroke();
  rect(10, 10, 220, 120, 10);
  
  // Indicador circular de zoom
  noFill();
  strokeWeight(3);
  stroke(200, 200, 255, 100);
  ellipse(width - 60, height - 60, 80, 80);
  
  // Aguja del zoom
  float anguloZoom = map(zoom, 0.1, 4.5, -PI/2, PI/2);
  stroke(200, 200, 255, 200);
  strokeWeight(4);
  line(width - 60, height - 60, 
       width - 60 + cos(anguloZoom) * 35, 
       height - 60 + sin(anguloZoom) * 35);
  
  // Valor del zoom en el indicador
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(12);
  text(nf(zoom, 1, 1) + "x", width - 60, height - 35);
}

void mousePressed() {
  // Cambia colores aleatoriamente
  colorFondo = color(random(200), random(200), random(200));
  colorBorde = color(random(255), random(255), random(255));
}
