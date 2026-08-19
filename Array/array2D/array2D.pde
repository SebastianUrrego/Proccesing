/**
 * Array 2D - Múltiples Agujeros Negros Dinámicos.
 * Los centros de atracción se mueven de forma orgánica por la pantalla,
 * recalculando la distancia en tiempo real para cada fotograma.
 */

// Variable para almacenar la distancia máxima de referencia y normalizar los colores
float maxDistance;
// Espaciado o densidad entre cada punto dibujado en la pantalla
int spacer;

/**
 * Configuración inicial del sketch.
 * Se ejecuta una sola vez al inicio del programa.
 */
void setup() {
  size(640, 360); // Define el tamaño de la ventana gráfica
  maxDistance = dist(0, 0, width/2, height/2); // Calcula la distancia de referencia máxima
  spacer = 10;          // Establece la separación entre los puntos de la malla
  strokeWeight(6);      // Define el grosor visual de cada punto renderizado
  // Se omite noLoop() para permitir que el método draw() se ejecute de forma continua y anime los centros
}

/**
 * Bucle de dibujo principal.
 * Se ejecuta fotograma a fotograma animando los focos de atracción y recalculando la matriz visual.
 */
void draw() {
  background(0); // Limpia la pantalla pintando un fondo de color negro puro
  
  // Variable de tiempo 't' basada en frameCount para controlar la velocidad del movimiento orgánico
  float t = frameCount * 0.02; 
  
  // Coordenadas dinámicas (X, Y) para el primer centro de atracción usando funciones trigonométricas
  float cx1 = width * 0.25 + sin(t) * 80;
  float cy1 = height * 0.25 + cos(t * 0.8) * 50;
  
  // Coordenadas dinámicas (X, Y) para el segundo centro de atracción
  float cx2 = width * 0.75 + cos(t * 1.2) * 80;
  float cy2 = height * 0.25 + sin(t) * 50;
  
  // Coordenadas dinámicas (X, Y) para el tercer centro de atracción
  float cx3 = width * 0.25 + sin(t * 0.9) * 70;
  float cy3 = height * 0.75 + cos(t) * 60;
  
  // Coordenadas dinámicas (X, Y) para el cuarto centro de atracción
  float cx4 = width * 0.75 + cos(t * 0.7) * 70;
  float cy4 = height * 0.75 + sin(t * 1.1) * 60;

  // Bucle anidado para recorrer la pantalla en intervalos definidos por el espaciador
  for (int y = 0; y < height; y += spacer) {
    for (int x = 0; x < width; x += spacer) {
      
      // Calcula la distancia euclidiana del punto actual (x, y) a cada uno de los 4 centros en movimiento
      float d1 = dist(cx1, cy1, x, y);
      float d2 = dist(cx2, cy2, x, y);
      float d3 = dist(cx3, cy3, x, y);
      float d4 = dist(cx4, cy4, x, y);
      
      // Utiliza funciones min() anidadas para obtener la distancia más corta hacia el centro más cercano
      float minDist = min(min(d1, d2), min(d3, d4));
      
      // Normaliza la distancia obtenida y la escala al rango de color de 0 a 255
      float c = minDist / maxDistance * 255;
      
      // Asigna el color resultante al trazo y dibuja el punto centrado en su celda correspondiente
      stroke(c);
      point(x + spacer/2, y + spacer/2);
    }
  }
}
