/**
 * Letras Vivas
 * -------------
 * Dibuja una tabla de caracteres en pantalla. El tamaño de las letras
 * varía con el tiempo y con la cercanía del mouse (efecto lupa), y el
 * color depende del tipo de caracter: vocal, consonante, número o
 * símbolo. Al hacer clic, la tabla avanza a otro rango de caracteres.
 */

PFont f;

float tamanoBase = 24;     // tamaño de letra de referencia
int inicioASCII   = 35;    // primer caracter que se dibuja

// Rango de caracteres ASCII imprimibles que se recorren
final int RANGO_INICIO = 33;
final int RANGO_FIN    = 126;
final int RANGO_TOTAL  = RANGO_FIN - RANGO_INICIO + 1;

void setup() {
  size(640, 360);
  background(0);

  // Intentamos cargar la fuente personalizada; si no está disponible
  // (por ejemplo, falta el archivo en la carpeta data/), usamos una
  // fuente monoespaciada del sistema como respaldo.
  f = createFont("SourceCodePro-Regular.ttf", 24);
  if (f == null) {
    f = createFont("Monospaced.plain", 24);
  }
  textFont(f);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(0);

  // Margen superior e izquierdo
  int margen = 10;
  translate(margen * 4, margen * 4);

  int separacion = 46;
  int contador = inicioASCII;

  // Posición del mouse en el mismo sistema de coordenadas que la grilla
  float mx = mouseX - margen * 4;
  float my = mouseY - margen * 4;

  for (int y = 0; y < height - separacion; y += separacion) {
    for (int x = 0; x < width - separacion; x += separacion) {

      // Mantenemos el código dentro del rango ASCII imprimible
      int codigo = RANGO_INICIO + ((contador - RANGO_INICIO) % RANGO_TOTAL);
      char letra = char(codigo);

      // Color según el tipo de caracter
      fill(colorSegunTipo(letra));

      // Tamaño: leve oscilación en el tiempo + agrandado cerca del mouse
      float respiracion = sin(frameCount * 0.05 + x * 0.05) * 3;
      float distancia = dist(mx, my, x, y);
      float lupa = map(constrain(distancia, 0, 100), 0, 100, 20, 0);
      textSize(tamanoBase + respiracion + lupa);

      // Leve flote vertical
      float flote = sin(frameCount * 0.04 + x * 0.1) * 3;

      text(letra, x, y + flote);

      contador++;
    }
  }
}

// Devuelve un color según el tipo de caracter: vocal, consonante,
// número o símbolo/puntuación.
color colorSegunTipo(char letra) {
  String vocales = "AEIOUaeiou";

  if (vocales.indexOf(letra) != -1) {
    return color(255, 204, 0);     // vocales: dorado
  } else if (Character.isLetter(letra)) {
    return color(255);             // consonantes: blanco
  } else if (Character.isDigit(letra)) {
    return color(0, 220, 255);     // números: cian
  } else {
    return color(255, 80, 180);    // símbolos y puntuación: rosa
  }
}

// Cada clic avanza la tabla a otro rango de caracteres
void mousePressed() {
  inicioASCII = RANGO_INICIO + ((inicioASCII - RANGO_INICIO + 90) % RANGO_TOTAL);
}
