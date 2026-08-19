# Sketches de Processing: Saturación y Gradientes Radiales
 
Documentación de los cuatro sketches que aparecieron en la conversación: los dos ejemplos originales de Processing y las dos versiones creativas que se hicieron a partir de ellos.
 
---
 
## 1. `Saturation` (original)
 
```java
int barWidth = 20;
int lastBar = -1;
 
void setup() {
  size(640, 360);
  colorMode(HSB, width, height, 100);
  noStroke();
}
 
void draw() {
  int whichBar = mouseX / barWidth;
  if (whichBar != lastBar) {
    int barX = whichBar * barWidth;
    fill(barX, mouseY, 66);
    rect(barX, 0, barWidth, height);
    lastBar = whichBar;
  }
}
```
 
**Qué hace:** divide el lienzo en columnas verticales de 20 píxeles (`barWidth`). Cada columna se pinta con `fill(barX, mouseY, 66)`: como `colorMode(HSB, width, height, 100)` mapea el rango de **hue** al ancho de la pantalla y el rango de **saturación** al alto, el resultado es que la posición X de la barra define su tono y la posición Y del mouse define qué tan saturado se ve ese tono. El brillo queda fijo en 66.
 
**El truco de rendimiento:** `lastBar` guarda cuál fue la última columna pintada. Solo se vuelve a dibujar cuando `mouseX` entra en una columna distinta (`whichBar != lastBar`), así que moverse dentro de la misma barra no repinta nada — solo cambia el color cuando cruzas a una nueva franja de 20px.
 
**Interacción:** mover el mouse verticalmente cambia la saturación de la barra bajo el cursor; moverlo horizontalmente cambia cuál barra se está pintando (y su tono).
 
---
 
## 2. `Saturation Ripples` (versión creativa) — `saturation_ripples.pde`
 
**Qué conserva del original:** la idea central de que la posición del cursor controla la saturación de lo que se dibuja.
 
**Qué cambia:**
- En vez de barras que solo se repintan al cambiar de columna, usa una **cuadrícula de círculos** que se redibuja completa en cada frame (animación continua, no solo reacción a movimiento).
- La saturación de cada círculo no depende directamente de `mouseY`, sino de una **onda que se propaga desde el cursor**:
```java
  float d = dist(cx, cy, mouseX, mouseY);
  float ripple = sin(d * 0.05 - t * 4.0);
  float falloff = constrain(1.0 - d / 380.0, 0, 1);
  float sat = 50 + ripple * 50 * falloff;
```
  `d` es la distancia del círculo al cursor, `t` es el tiempo en segundos (`millis()/1000.0`). El `sin(d * 0.05 - t * 4.0)` genera anillos concéntricos de saturación alta/baja que se expanden con el tiempo, y `falloff` hace que el efecto se apague mientras más lejos esté el círculo del cursor.
- El **tono (hue)** ya no es fijo por posición: se calcula con `(x * 0.4 + y * 0.2 + t * 20) % 360`, así que va derivando en diagonal por toda la pantalla incluso si no mueves el mouse.
- El **brillo** y el **tamaño** de cada círculo también crecen cerca del cursor (`bri`, `sizeMod`), dando sensación de profundidad.
**Interacción:** mover el mouse envía ondas de saturación que se expanden por la cuadrícula; la escena sigue "respirando" (tono cambiando) aunque el mouse esté quieto.
 
**Parámetros para experimentar:**
| Variable / expresión | Efecto |
|---|---|
| `cellSize` | tamaño de la cuadrícula (más chico = más detalle, más costo) |
| `d * 0.05` | qué tan comprimidas van las ondas |
| `t * 4.0` | qué tan rápido viajan las ondas |
| `d / 380.0` | qué tan lejos llega la influencia del cursor |
 
---
 
## 3. `Radial Gradient` (original)
 
```java
int dim;
 
void setup() {
  size(640, 360);
  dim = width/2;
  background(0);
  colorMode(HSB, 360, 100, 100);
  noStroke();
  ellipseMode(RADIUS);
  frameRate(1);
}
 
void draw() {
  background(0);
  for (int x = 0; x <= width; x+=dim) {
    drawGradient(x, height/2);
  } 
}
 
void drawGradient(float x, float y) {
  int radius = dim/2;
  float h = random(0, 360);
  for (int r = radius; r > 0; --r) {
    fill(h, 90, 90);
    ellipse(x, y, r, r);
    h = (h + 1) % 360;
  }
}
```
 
**Qué hace:** `drawGradient()` dibuja un gradiente radial pintando círculos concéntricos de afuera hacia adentro (`ellipseMode(RADIUS)` hace que el tercer/cuarto argumento de `ellipse()` sea el radio, no el diámetro). Cada círculo que se dibuja encima es un poco más chico y con el hue incrementado en 1°, así que los círculos exteriores quedan visibles como anillos de color alrededor de los interiores — de ahí el efecto de "gradiente".
 
`draw()` coloca tres de estos gradientes (`x = 0, dim, 2*dim`, es decir en `0`, `320` y `640`) alineados en el centro vertical. Como `frameRate(1)` limita el sketch a 1 frame por segundo, cada segundo se recalcula todo con un color inicial (`h = random(0,360)`) distinto: es una sucesión de "fotos" estáticas, no una animación fluida.
 
---
 
## 4. `Radial Bloom` (versión creativa) — `radial_bloom.pde`
 
**Qué conserva del original:** la técnica central — anillos concéntricos con el hue rotando hacia afuera para formar un gradiente radial (`ellipseMode(RADIUS)`, incremento de hue por anillo).
 
**Qué cambia:**
- Reemplaza las "fotos" fijas (una por segundo) por un **sistema de partículas** (`class Bloom`): cada gradiente ahora es un objeto con posición, velocidad, tiempo de vida y radio máximo propios, y la animación corre a la velocidad normal del sketch (no a 1 fps).
- Cada `Bloom` tiene un **ciclo de vida**: nace, crece, se encoge y desaparece, controlado por
```java
  float lifeT = age / lifespan;   // 0 → 1 a lo largo de su vida
  float growth = sin(lifeT * PI); // crece y luego se encoge suavemente
```
  `sin(lifeT * PI)` va de 0 a 1 y de vuelta a 0 conforme `lifeT` va de 0 a 1 — una curva de "inhala/exhala" natural para el tamaño y la opacidad.
- Los blooms **se mueven** (`vx`, `vy` aleatorios y pequeños) en vez de quedarse fijos en `0`, `320` o `640`.
- Usa **`blendMode(ADD)`** al dibujar los anillos, así que donde dos gradientes se superponen, sus colores se **suman** (se ven más brillantes) en vez de que uno tape al otro. Por eso `draw()` alterna el modo de mezcla:
```java
  blendMode(BLEND); background(0);  // limpiar el fondo normalmente
  blendMode(ADD);                   // pintar los blooms sumando color
```
  (si no se hiciera este cambio de modo, `background(0)` no limpiaría bien la pantalla bajo `ADD`, porque sumar negro no borra nada).
- Aparecen blooms nuevos solos cada 40 frames (`frameCount % 40 == 0`), y también **al hacer clic** (`mousePressed()`), a diferencia del original que no tenía ninguna interacción de mouse.
**Interacción:** haz clic en cualquier parte del lienzo para plantar un nuevo florecimiento de color ahí; otros van apareciendo solos con el tiempo, se mueven, crecen, se desvanecen y se mezclan entre sí.
 
**Parámetros para experimentar:**
| Variable / expresión | Efecto |
|---|---|
| `frameCount % 40` | cada cuántos frames nace un bloom nuevo por su cuenta |
| `random(-0.3, 0.3)` (`vx`, `vy`) | velocidad de deriva de cada bloom |
| `random(90, 180)` (`lifespan`) | cuánto vive cada bloom |
| `random(40, 100)` (`maxRadius`) | qué tan grande llega a ser |
| `r -= 2` en el bucle de anillos | separación entre anillos (más chico = degradado más suave, más costo) |
 
---
 
