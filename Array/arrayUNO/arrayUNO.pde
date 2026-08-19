/**
 * Array. 
 * 
 * Un arreglo es una lista de datos. Cada dato se identifica por un número de índice 
 * que representa su posición. Comienzan en 0. En este ejemplo, el arreglo "coswave" 
 * almacena valores matemáticos que luego se dibujan en tres secciones de la pantalla.  
 */

float[] coswave; 

void setup() {
  size(640, 360);
  coswave = new float[width]; // Creamos el arreglo con un tamaño igual al ancho de la ventana
  
  // Rellenamos el arreglo combinando funciones trigonométricas
  for (int i = 0; i < width; i++) {
    // Mapeamos la posición horizontal a un rango de ciclos extendido (TWO_PI * 2)
    float amount = map(i, 0, width, 0, TWO_PI * 2); 
    // Mezclamos seno y coseno para generar una onda asimétrica y valor absoluto para evitar negativos
    coswave[i] = abs(sin(amount) * cos(amount * 0.5)); 
  }
  
  // Configuramos el modo de color a HSB (Matiz, Saturación, Brillo)
  colorMode(HSB, 360, 100, 100);
  background(0); // Fondo negro inicial
  noLoop(); // Ejecutamos el draw una sola vez
}

void draw() {
  // --- SECCIÓN SUPERIOR ---
  int y1 = 0;
  int y2 = height/3;
  for (int i = 0; i < width; i++) {
    // El matiz (Hue) cambia progresivamente de izquierda a derecha según la posición 'i',
    // mientras que el brillo (Brightness) se modula con los valores del arreglo 'coswave'.
    stroke(map(i, 0, width, 0, 360), 80, coswave[i] * 100);
    line(i, y1, i, y2);
  }

  // --- SECCIÓN CENTRAL ---
  y1 = y2;
  y2 = y1 + y1;
  for (int i = 0; i < width; i++) {
    // El matiz (Hue) ahora depende directamente del valor del arreglo 'coswave',
    // creando franjas de colores repetitivas y vibrantes a lo largo del ancho.
    stroke(map(coswave[i], 0, 1, 0, 360), 50, 90);
    line(i, y1, i, y2);
  }
  
  // --- SECCIÓN INFERIOR ---
  y1 = y2;
  y2 = height;
  for (int i = 0; i < width; i++) {
    // Se fija un matiz azul (200), y la saturación varía de acuerdo al arreglo 'coswave',
    // generando un efecto de desvanecimiento suave y metálico.
    stroke(200, map(coswave[i], 0, 1, 20, 100), 70);
    line(i, y1, i, y2);
  }
}
