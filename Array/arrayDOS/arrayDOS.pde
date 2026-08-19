/**
 * Array como Columnas Interactivas Avanzadas.
 * MouseX controla el ancho de columna.
 * MouseY controla el brillo global (atenuación).
 */

// Declaración del arreglo global que almacenará los valores matemáticos de la onda
float[] coswave; 

/**
 * Configuración inicial del sketch.
 * Se ejecuta una sola vez al iniciar el programa.
 */
void setup() {
  size(640, 360); // Define el tamaño de la ventana de visualización
  coswave = new float[width]; // Inicializa el arreglo con un tamaño igual al ancho de la pantalla
  
  // Rellena el arreglo calculando el valor absoluto del coseno para cada posición horizontal
  for (int i = 0; i < width; i++) {
    float amount = map(i, 0, width, 0, PI);
    coswave[i] = abs(cos(amount));
  }
  
  background(20); // Establece el color de fondo inicial en gris oscuro
  noStroke();     // Desactiva los bordes de las figuras geométricas
  colorMode(RGB, 255); // Configura el sistema de colores en RGB con escala de 0 a 255
}

/**
 * Bucle de dibujo principal.
 * Se encarga de actualizar y renderizar los elementos gráficos en pantalla de forma interactiva.
 */
void draw() {
  background(20); // Limpia el fotograma anterior pintando el fondo de gris oscuro
  
  // EJE X: Controla el ancho dinámico de las columnas según la posición horizontal del mouse
  int colWidth = int(map(mouseX, 0, width, 10, 50));
  if (colWidth < 5) colWidth = 5; // Asegura un valor mínimo de 5 para evitar errores visuales o de división

  // EJE Y: Mapea la posición vertical del mouse para atenuar el brillo global (de 0.0 a 1.0)
  float brightnessFactor = map(mouseY, 0, height, 0.0, 1.0);
  brightnessFactor = constrain(brightnessFactor, 0.0, 1.0); // Limita estrictamente el factor entre 0 y 1

  // --- SECCIÓN SUPERIOR ---
  int y1 = 0;
  int y2 = height/3;
  for (int i = 0; i < width; i += colWidth) {
    int index = min(i, coswave.length - 1); // Protege contra desbordamientos de índice en el arreglo
    // Asigna el color de relleno aplicando el valor del arreglo, el factor RGB y la atenuación del mouse
    fill(coswave[index] * 255 * brightnessFactor, 200 * brightnessFactor);
    rect(i, y1, colWidth - 2, y2 - y1); // Dibuja la columna rectangular superior
  }

  // --- SECCIÓN CENTRAL ---
  y1 = y2;
  y2 = y1 + y1;
  for (int i = 0; i < width; i += colWidth) {
    int index = min(i, coswave.length - 1); // Protege contra desbordamientos de índice
    // Asigna un color de relleno atenuado y dividido para la sección del medio
    fill(coswave[index] * 255 / 3 * brightnessFactor, 150 * brightnessFactor);
    rect(i, y1, colWidth - 2, y2 - y1); // Dibuja la columna rectangular central
  }
  
  // --- SECCIÓN INFERIOR ---
  y1 = y2;
  y2 = height;
  for (int i = 0; i < width; i += colWidth) {
    int index = min(i, coswave.length - 1); // Protege contra desbordamientos de índice
    // Asigna un color invertido y atenuado por la posición vertical del mouse
    fill(255 - coswave[index] * 255 * brightnessFactor);
    rect(i, y1, colWidth - 2, y2 - y1); // Dibuja la columna rectangular inferior
  }
}

/**
 * Evento que se activa al mover el cursor.
 * Fuerza a que el método draw() se ejecute nuevamente para reflejar los cambios interactivos del mouse.
 */
void mouseMoved() {
  redraw();
}
