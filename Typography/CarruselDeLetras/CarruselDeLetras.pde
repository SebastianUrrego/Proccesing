/**
 * Carrusel de letras
 * ---------------------------------------------------------
 * Tres textos giran alrededor de tres puntos fijos, cada uno
 * con una fuente distinta para que el carrusel se vea variado:
 * una fuente tipo sello ("Stencil"), una fuente caligráfica
 * ("Vladimir Script") y una fuente redonda y juguetona
 * ("Snap ITC") para el texto que gira sin parar en el centro.
 *
 * El boceto también incluye:
 * - Una estela de color: el fondo no se borra del todo en cada
 *   cuadro, sino que se cubre con un negro semi-transparente,
 *   dejando un rastro parecido a las luces de una feria en
 *   movimiento.
 * - Un ciclo de color (modo HSB) que cambia el tono de cada
 *   texto y de su línea con el paso del tiempo.
 * - Un "respiro" en el tamaño del texto central: crece y
 *   encoge suavemente siguiendo una onda seno.
 * - Pequeños focos (círculos que titilan) repartidos sobre
 *   cada línea, como si fueran bombillas de una guirnalda.
 * - Un halo de círculos concéntricos alrededor de cada punto
 *   de giro, para dar sensación de brillo.
 *
 * Como no hay ningún archivo .ttf dentro de la carpeta "data",
 * las tres fuentes se crean con createFont() a partir de
 * fuentes que ya están instaladas en el sistema.
 */

PFont fuenteSello;       // fuente estilo "Stencil" para el primer texto
PFont fuenteCaligrafica; // fuente estilo "Vladimir Script" para el segundo texto
PFont fuenteCentral;     // fuente estilo "Snap ITC" para el texto que gira sin parar

float anguloGiro = 0.0;  // ángulo del texto central, aumenta en cada cuadro
float cicloColor = 0.0;  // controla el cambio de color con el paso del tiempo

void setup() {
  size(640, 360);
  colorMode(HSB, 360, 100, 100, 100); // matiz, saturación, brillo, transparencia
  background(0);

  // Se crean las tres fuentes a partir de fuentes del sistema.
  fuenteSello = createFont("Stencil", 22);
  fuenteCaligrafica = createFont("Vladimir Script", 30);
  fuenteCentral = createFont("Snap ITC", 20);

  textAlign(LEFT, CENTER);
}

void draw() {
  // En vez de limpiar la pantalla por completo, se pinta un
  // rectángulo negro casi transparente encima de todo. Así queda
  // una pequeña estela detrás de cada letra en movimiento.
  noStroke();
  fill(0, 0, 0, 12);
  rect(0, 0, width, height);

  cicloColor += 0.6; // el color avanza un poco en cada cuadro

  // ---------- Texto 1: ángulo fijo de 45 grados ----------
  pushMatrix();
  float angulo1 = radians(45);
  translate(100, 180);
  rotate(angulo1);
  textFont(fuenteSello);
  float tono1 = cicloColor % 360;
  stroke(tono1, 80, 100);
  fill(tono1, 80, 100);
  strokeWeight(1);
  text("45 GRADOS", 0, 0);
  line(0, 0, 150, 0);
  dibujarFocos(150, tono1);
  popMatrix();

  // ---------- Texto 2: ángulo fijo de 270 grados ----------
  pushMatrix();
  float angulo2 = radians(270);
  translate(200, 180);
  rotate(angulo2);
  textFont(fuenteCaligrafica);
  float tono2 = (cicloColor + 120) % 360; // color desfasado del anterior
  stroke(tono2, 80, 100);
  fill(tono2, 80, 100);
  strokeWeight(1);
  text("270 grados", 0, 0);
  line(0, 0, 150, 0);
  dibujarFocos(150, tono2);
  popMatrix();

  // ---------- Texto 3: gira de forma continua ----------
  pushMatrix();
  translate(440, 180);
  rotate(radians(anguloGiro));
  textFont(fuenteCentral);
  float tono3 = (cicloColor + 240) % 360;
  // El tamaño del texto "respira": crece y encoge con una onda seno
  float tamano = 20 + sin(frameCount * 0.05) * 6;
  textSize(tamano);
  stroke(tono3, 80, 100);
  fill(tono3, 80, 100);
  strokeWeight(1);
  text(int(anguloGiro) % 360 + " GRADOS", 0, 0);
  line(0, 0, 150, 0);
  dibujarFocos(150, tono3);
  popMatrix();

  anguloGiro += 0.6;

  // ---------- Puntos centrales con halo de brillo ----------
  dibujarPuntoConHalo(100, 180, cicloColor % 360);
  dibujarPuntoConHalo(200, 180, (cicloColor + 120) % 360);
  dibujarPuntoConHalo(440, 180, (cicloColor + 240) % 360);
}

/**
 * Dibuja pequeños focos (círculos) repartidos a lo largo de una
 * línea horizontal que empieza en (0,0), simulando una guirnalda
 * de luces de feria. Se llama dentro de un pushMatrix/popMatrix
 * que ya está trasladado y rotado, así que las coordenadas son
 * relativas a esa línea.
 */
void dibujarFocos(float largo, float tono) {
  noStroke();
  for (float d = 20; d < largo; d += 25) {
    // el brillo de cada foco varía con el tiempo y su posición,
    // para que parezca que las luces titilan
    float brillo = 60 + 40 * sin(frameCount * 0.1 + d);
    fill(tono, 90, brillo);
    ellipse(d, 0, 6, 6);
  }
}

/**
 * Dibuja el punto de giro junto con un halo de círculos
 * concéntricos, cada uno más grande y transparente que el
 * anterior, para dar un efecto de brillo alrededor del punto.
 */
void dibujarPuntoConHalo(float x, float y, float tono) {
  noStroke();
  for (int i = 3; i >= 1; i--) {
    fill(tono, 70, 100, 30);
    ellipse(x, y, 8 * i, 8 * i);
  }
  fill(tono, 20, 100);
  ellipse(x, y, 6, 6);
}
