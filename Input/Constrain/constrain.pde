/**
 * Constrain — Rebote Elástico
 *
 * Mover el mouse por la pantalla desplaza al círculo.
 * El círculo permanece dentro de una caja central y, al llegar
 * a uno de sus bordes, rebota conservando parte de su velocidad.
 */

float mx, my;            // posición actual del círculo
float vx, vy;            // velocidad actual del círculo en cada eje
float easing = 0.05;     // fuerza con la que la velocidad se ajusta hacia la posición del mouse
float bounce = 0.65;     // fracción de la velocidad que se conserva después de un rebote
float friction = 0.92;   // fracción de la velocidad que se conserva en cada frame, reduciendo la energía con el tiempo
int radius = 24;         // radio del círculo
int edge = 100;          // distancia entre el borde de la caja y el borde de la pantalla
int inner = edge + radius;  // límite efectivo para el centro del círculo, considerando su radio

void setup() {
  size(640, 360);
  noStroke();
  ellipseMode(RADIUS);
  rectMode(CORNERS);
  mx = width / 2;    // el círculo inicia en el centro horizontal de la pantalla
  my = height / 2;   // el círculo inicia en el centro vertical de la pantalla
}

void draw() {
  background(51);

  // la velocidad se incrementa en proporción a la distancia entre el círculo y el mouse
  vx += (mouseX - mx) * easing;
  vy += (mouseY - my) * easing;

  // la fricción reduce la velocidad en cada frame
  vx *= friction;
  vy *= friction;

  // la posición se actualiza según la velocidad calculada
  mx += vx;
  my += vy;

  // al alcanzar el límite izquierdo o derecho, la posición se ajusta al límite
  // y la velocidad horizontal se invierte y se reduce según "bounce"
  if (mx < inner) {
    mx = inner;
    vx *= -bounce;
  } else if (mx > width - inner) {
    mx = width - inner;
    vx *= -bounce;
  }

  // al alcanzar el límite superior o inferior, la posición se ajusta al límite
  // y la velocidad vertical se invierte y se reduce según "bounce"
  if (my < inner) {
    my = inner;
    vy *= -bounce;
  } else if (my > height - inner) {
    my = height - inner;
    vy *= -bounce;
  }

  fill(76);
  rect(edge, edge, width - edge, height - edge);  // caja que delimita el movimiento del círculo
  fill(255);
  ellipse(mx, my, radius, radius);  // círculo que sigue al mouse
}
