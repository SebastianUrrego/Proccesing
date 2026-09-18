/**
 * Palabras con tinta.
 *
 * Este sketch dibuja los números del uno al cuatro en japonés
 * (ichi, ni, san, shi) usando "Yu Gothic Regular", una tipografía
 * del sistema que incluye tanto el alfabeto latino como los
 * caracteres japoneses. Cada palabra en rōmaji va acompañada de
 * su kanji correspondiente, escrito con la misma fuente.
 *
 * El tamaño de cada letra oscila muy suavemente con el tiempo,
 * como si el trazo de un pincel todavía estuviera asentándose
 * sobre el papel. El fondo imita el tono cálido de un papel de
 * arroz (washi) y las líneas guía recuerdan a las de una hoja de
 * práctica de caligrafía. En la esquina inferior derecha aparece
 * un pequeño sello rojo (hanko), el tipo de sello que un
 * calígrafo japonés estampa junto a su firma cuando una pieza
 * está terminada.
 */

PFont f;

// Los cuatro números en rōmaji y su kanji correspondiente
String[] romaji = { "ichi", "ni", "san", "shi" };
String[] kanji  = { "一", "二", "三", "四" };

// Tonos de "tinta": del trazo más cargado al más diluido
color[] tinta = { color(15), color(65), color(115), color(165) };

void setup() {
  size(640, 360);
  // "Yu Gothic Regular" es una fuente del sistema pensada para
  // texto japonés: por eso el rōmaji y el kanji se pueden dibujar
  // con la misma tipografía, sin necesidad de un archivo .ttf.
  f = createFont("Yu Gothic Regular", 28);
  textFont(f);
}

void draw() {
  // Fondo cálido, como un papel de arroz
  background(232, 221, 196);

  textAlign(RIGHT);
  drawColumn(width * 0.25, 0);
  textAlign(CENTER);
  drawColumn(width * 0.5, 1);
  textAlign(LEFT);
  drawColumn(width * 0.75, 2);

  drawSello();
}

void drawColumn(float x, int fase) {
  // Líneas guía suaves, como las de una hoja de práctica de caligrafía
  stroke(178, 158, 128);
  line(x, 0, x, 55);
  line(x, 280, x, height);
  noStroke();

  for (int i = 0; i < romaji.length; i++) {
    // Cada palabra "respira": su tamaño cambia poco a poco con el
    // tiempo, con una fase distinta según la columna y la palabra,
    // para que el vaivén no se vea sincronizado en todo el lienzo.
    float pulso = sin(frameCount * 0.03 + i + fase) * 3;
    float y = 90 + i * 50;

    textSize(28 + pulso);
    fill(tinta[i]);
    text(romaji[i], x, y);

    // El kanji aparece más pequeño justo debajo, a modo de
    // traducción escrita con un trazo más fino y más claro.
    textSize(15 + pulso * 0.4);
    fill(tinta[i], 190);
    text(kanji[i], x, y + 22);
  }
}

void drawSello() {
  // Un sello rojo (hanko) en la esquina, como el que acompaña
  // a una pieza de caligrafía japonesa ya terminada.
  pushStyle();
  noStroke();
  fill(178, 34, 34);
  rect(width - 54, height - 54, 34, 34);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("印", width - 54 + 17, height - 54 + 17);
  popStyle();
}
