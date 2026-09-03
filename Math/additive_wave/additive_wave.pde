/**
 * Onda aditiva con velocidad y colores arcoíris
 */

int xspacing = 8;
int w;
int maxwaves = 4;

float theta = 0.0;

float[] amplitude = new float[maxwaves];
float[] dx = new float[maxwaves];
float[] yvalues;

void setup() {
  size(640, 360);
  frameRate(60);

  colorMode(HSB, 360, 100, 100, 100);

  w = width + 16;

  for (int i = 0; i < maxwaves; i++) {
    amplitude[i] = random(10, 30);

    float period = random(100, 300);
    dx[i] = (TWO_PI / period) * xspacing;
  }

  yvalues = new float[w / xspacing];
}

void draw() {
  background(0);

  calcWave();
  renderWave();
}

void calcWave() {

  // La velocidad depende de la posición del mouse
  // Izquierda = lento
  // Derecha = rápido
  float velocidad = map(mouseX, 0, width, 0.005, 0.1);

  theta += velocidad;

  // Reiniciar los valores
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = 0;
  }

  // Sumar las ondas
  for (int j = 0; j < maxwaves; j++) {

    float x = theta;

    for (int i = 0; i < yvalues.length; i++) {

      if (j % 2 == 0) {
        yvalues[i] += sin(x) * amplitude[j];
      } 
      else {
        yvalues[i] += cos(x) * amplitude[j];
      }

      x += dx[j];
    }
  }
}

void renderWave() {

  noFill();
  strokeWeight(4);

  beginShape();

  for (int x = 0; x < yvalues.length; x++) {

    // Color arcoíris que cambia con el tiempo
    float hue = (x * 2 + theta * 30) % 360;

    stroke(hue, 100, 100);

    vertex(
      x * xspacing,
      height/2 + yvalues[x]
    );
  }

  endShape();
}
