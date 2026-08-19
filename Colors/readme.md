# Sketches de Processing: Saturación, Gradientes Radiales y Relatividad del Color

Documentación de los seis sketches que aparecieron en la conversación, organizados en tres parejas de **original de Processing → variación creativa**: Saturación, Gradiente Radial y Relatividad del Color.

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

## 5. `Relativity` (original)

```java
color a, b, c, d, e;

void setup() {
  size(640, 360);
  noStroke();
  a = color(165, 167, 20);
  b = color(77, 86, 59);
  c = color(42, 106, 105);
  d = color(165, 89, 20);
  e = color(146, 150, 127);
  noLoop();  // Draw only one time
}

void draw() {
  drawBand(a, b, c, d, e, 0, width/128);
  drawBand(c, a, d, b, e, height/2, width/128);
}

void drawBand(color v, color w, color x, color y, color z, int ypos, int barWidth) {
  int num = 5;
  color[] colorOrder = { v, w, x, y, z };
  for (int i = 0; i < width; i += barWidth*num) {
    for (int j = 0; j < num; j++) {
      fill(colorOrder[j]);
      rect(i+j*barWidth, ypos, barWidth, height/2);
    }
  }
}
```

**Qué hace:** define cinco colores fijos (`a`–`e`) y los reparte en franjas delgadas (`width/128` ≈ 5px de ancho) que se repiten en grupos de `num = 5` a lo largo de todo el lienzo. `drawBand()` recibe los cinco colores **en un orden** y los va colocando uno junto al otro, repitiendo el ciclo hasta llenar el ancho.

La clave está en que las dos bandas usan **exactamente los mismos cinco colores**, solo que en **orden distinto**: arriba `(a, b, c, d, e)`, abajo `(c, a, d, b, e)`. Como cada color termina con vecinos distintos en cada banda, se percibe diferente aunque sea el mismo valor RGB — por eso el color `c`, por ejemplo, se ve más o menos intenso según a qué colores esté pegado. `noLoop()` hace que `draw()` se ejecute una sola vez, porque la comparación no necesita animación: es una ilustración estática.

---

## 6. `Relativity: The Same Gray` (variación) — `relativity_same_gray.pde`

**Qué conserva del original:** el mismo fenómeno de fondo — que un color se percibe distinto según lo que lo rodea — pero lo demuestra con **un solo gris fijo** en vez de reordenar una paleta de cinco colores.

**Cómo funciona:**
- Divide el lienzo en una cuadrícula de `cols × rows` (8×5) celdas.
- Dentro de cada celda dibuja un cuadrito pequeño con `sameGray = color(0, 0, 55)` — literalmente el mismo gris, sin variación alguna, en las 40 celdas.
- El **fondo de cada celda** sí cambia: cada una tiene una semilla de tono aleatoria (`hueSeed[idx]`) que además va derivando lentamente con el tiempo:
  ```java
  float hue = (hueSeed[idx] + t * 15) % 360;
  fill(hue, 75, 65);
  ```
  Esto hace que los 40 fondos vayan cambiando de color de forma independiente y continua, a diferencia del `Relativity` original que es una sola imagen fija.
- Al presionar **ESPACIO** (`keyPressed()`), `revealed` se invierte: los fondos de color dejan de dibujarse y el `pad` (margen alrededor del cuadrito gris) se reduce, así que los cuadritos grises crecen y quedan solos sobre un fondo neutro — la prueba visual de que, sin el contexto de color, todos son idénticos.

**Interacción:** presiona ESPACIO para alternar entre "con contexto de color" (la ilusión activa) y "sin contexto" (revela que es el mismo gris en todas partes).

**Parámetros para experimentar:**
| Variable / expresión | Efecto |
|---|---|
| `cols`, `rows` | densidad de la cuadrícula (más celdas = más comparaciones simultáneas) |
| `sameGray = color(0, 0, 55)` | qué gris se usa como "control"; con 0 y 100 la ilusión se debilita porque son extremos |
| `t * 15` | qué tan rápido derivan los tonos de fondo |
| `cellW * 0.28` vs `cellW * 0.08` | qué tanto crecen los cuadritos grises al revelar (contraste antes/después) |

---
