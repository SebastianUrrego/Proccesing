/**
 * Array Objects - Modificado e Interactivo.
 * Demuestra la creación de un arreglo de objetos personalizados con 
 * comportamiento dinámico, color adaptativo e interactividad con el mouse.
 */

int unit = 40;
int count;
Module[] mods;

void setup() {
  size(640, 360);
  noStroke();
  colorMode(HSB, 360, 100, 100); // Cambiamos a modo HSB para manejar colores fluidos
  
  int wideCount = width / unit;
  int highCount = height / unit;
  count = wideCount * highCount;
  mods = new Module[count];

  int index = 0;
  for (int y = 0; y < highCount; y++) {
    for (int x = 0; x < wideCount; x++) {
      // Inicializa cada objeto pasando su posición, tamaño y una velocidad aleatoria
      mods[index++] = new Module(x * unit, y * unit, unit / 2, unit / 2, random(0.05, 0.8), unit);
    }
  }
}

void draw() {
  background(20); // Fondo gris muy oscuro
  
  // Cambia la velocidad global de animación de los módulos según la posición X del mouse
  float speedMultiplier = map(mouseX, 0, width, 0.2, 3.0);

  // Recorre el arreglo de objetos mediante un bucle for-each para actualizarlos y dibujarlos
  for (Module mod : mods) {
    mod.update(speedMultiplier); // Actualiza la posición y estado del módulo
    mod.display();               // Renderiza el módulo en pantalla
  }
}

/**
 * Clase Module que define el comportamiento individual de cada elemento del arreglo.
 */
class Module {
  float xOffset;
  float yOffset;
  float x;
  float y;
  float speed;
  int unitSize;
  float angle = 0.0; // Ángulo interno para la animación trigonométrica

  // Constructor para inicializar las propiedades del módulo
  Module(float xTemp, float yTemp, float xO, float yO, float s, int u) {
    x = xTemp;
    y = yTemp;
    xOffset = xO;
    yOffset = yO;
    speed = s;
    unitSize = u;
  }

  // Actualiza el ángulo de movimiento según la velocidad modificada por el mouse
  void update(float speedMod) {
    angle += speed * speedMod;
  }

  // Dibuja el objeto en la pantalla con efectos de color dinámicos
  void display() {
    pushMatrix();
    translate(x, y);
    
    // El matiz (Hue) rota cíclicamente usando el seno y el ángulo interno
    float hueValue = (sin(angle) * 180) + 180;
    // El tamaño cambia orgánicamente con la onda
    float sizeFactor = abs(cos(angle)) * (unitSize * 0.8);
    
    fill(hueValue, 80, 90);
    // Dibuja una elipse centrada en la celda del módulo
    ellipse(xOffset, yOffset, sizeFactor, sizeFactor);
    
    popMatrix();
  }
}
