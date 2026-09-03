/**
 * Robot Interactivo con Teclado
 * Presiona + para agrandar, - para achicar
 */

PShape bot;
float escala = 1.0;

void setup() {
  size(640, 360);
  // El archivo "bot1.svg" debe estar en la carpeta data
  bot = loadShape("bot1.svg");
} 

void draw() {
  background(102);
  
  // Dibuja el robot con la escala actual
  // Centrado en la pantalla
  float ancho = 100 * escala;
  float alto = 100 * escala;
  float x = (width - ancho) / 2;   // Centra horizontalmente
  float y = (height - alto) / 2;   // Centra verticalmente
  
  shape(bot, x, y, ancho, alto);
  
}

void keyPressed() {
  // Aumenta o disminuye la escala con + y -
  if (key == '+') {
    escala = escala + 0.1;
  } else if (key == '-') {
    escala = escala - 0.1;
  }
  
  // Limita la escala entre 0.2 y 3.0
  escala = constrain(escala, 0.2, 3.0);
  
  // Muestra en consola el valor actual (opcional)
  println("Escala: " + escala);
}
