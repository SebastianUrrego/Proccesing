/**
 * Keyboard.
 *
 * Haga clic sobre la imagen para darle foco y presione teclas de letras
 * para crear barras verticales de color en el lienzo. Cada barra se
 * desplaza hacia su posición objetivo mediante un modelo de resorte,
 * de modo que sobrepasa el punto de destino y rebota elásticamente
 * antes de detenerse. Cada barra nueva parte desde la posición donde
 * quedó la barra anterior, lo que genera una sensación de continuidad
 * entre teclas sucesivas. Presionar una tecla que no sea una letra
 * elimina todas las barras de la pantalla.
 */

int rectWidth;          // Ancho de cada barra vertical, un cuarto del ancho del lienzo.
float stiffness = 0.08; // Rigidez del resorte: qué tan fuerte atrae la barra hacia su objetivo.
float damping = 0.9;    // Fracción de velocidad que se conserva en cada cuadro; regula el rebote antes de asentarse.

ArrayList<Bar> bars;    // Conjunto de todas las barras creadas hasta el momento.

void setup() {
  size(640, 360);
  noStroke();
  background(0);
  rectWidth = width / 4;
  bars = new ArrayList<Bar>();
}

void draw() {
  // El fondo se redibuja en cada cuadro porque las posiciones de las barras
  // se recalculan continuamente; todas las barras creadas hasta el momento
  // se vuelven a dibujar para mantener visible el conjunto completo de formas.
  background(0);
  for (Bar b : bars) {
    b.update();
    b.display();
  }
}

void keyPressed() {
  int keyIndex = -1;
  if (key >= 'A' && key <= 'Z') {
    keyIndex = key - 'A';
  } else if (key >= 'a' && key <= 'z') {
    keyIndex = key - 'a';
  }

  if (keyIndex == -1) {
    // Si la tecla no es una letra, se eliminan todas las barras del lienzo.
    bars.clear();
  } else {
    // La posición objetivo depende de la letra presionada: cada letra del
    // alfabeto corresponde a un punto distinto a lo largo del ancho del lienzo.
    float target = map(keyIndex, 0, 25, 0, width - rectWidth);
    float shade = millis() % 255;

    // La barra nueva parte desde la posición objetivo de la barra anterior
    // (o desde el centro del lienzo si todavía no existe ninguna), y desde
    // ahí el modelo de resorte la conduce hasta su propio objetivo.
    float startX = bars.isEmpty() ? (width - rectWidth) / 2.0 : bars.get(bars.size() - 1).target;
    bars.add(new Bar(startX, target, shade));
  }
}

// Representa una barra vertical individual que se desplaza mediante un
// modelo de resorte hasta alcanzar su posición objetivo.
class Bar {
  float x;         // Posición horizontal actual de la barra.
  float target;    // Posición horizontal a la que la barra debe llegar.
  float velocity;  // Velocidad horizontal actual, se acumula cuadro a cuadro.
  float shade;     // Tono de gris con el que se dibuja la barra.

  Bar(float startX, float _target, float _shade) {
    x = startX;
    target = _target;
    velocity = 0;
    shade = _shade;
  }

  // Aplica un paso del modelo de resorte: la aceleración es proporcional
  // a la distancia hasta el objetivo, y la velocidad se atenúa en cada
  // cuadro para que el movimiento termine por estabilizarse.
  void update() {
    float acceleration = (target - x) * stiffness;
    velocity += acceleration;
    velocity *= damping;
    x += velocity;
  }

  // Dibuja la barra en su posición actual con su tono correspondiente.
  void display() {
    fill(shade);
    rect(x, 0, rectWidth, height);
  }
}
