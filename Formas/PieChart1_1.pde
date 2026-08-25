/**
 * Pie Chart
 * 
 * Uses the arc() function to generate a pie chart from the data
 * stored in an array.
 */

int[] angles = { 30, 30, 45, 35, 60, 38, 75, 67 };

color[] colores = {
  color(255, 0, 0),      // rojo
  color(0, 255, 0),      // verde
  color(0, 0, 255),      // azul
  color(255, 255, 0),    // amarillo
  color(255, 0, 255),    // magenta
  color(0, 255, 255),    // cian
  color(255, 128, 0),    // naranja
  color(128, 0, 255)     // violeta
};

void setup() {
  size(640, 360);
  noStroke();
  noLoop();  
}

void draw() {
  background(255);
  pieChart(300, angles);
}

void pieChart(float diameter, int[] data) {
  float lastAngle = 0;

  for (int i = 0; i < data.length; i++) {
    
    // Selecciona un color diferente para cada parte
    fill(colores[i]);

    // Dibuja cada parte del gráfico
    arc(
      width/2,
      height/2,
      diameter,
      diameter,
      lastAngle,
      lastAngle + radians(data[i])
    );

    // Actualiza el ángulo
    lastAngle += radians(data[i]);
  }
}
