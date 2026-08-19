/**
 * Radial Bloom
 *
 * Un campo vivo de gradientes radiales: florecimientos de color crecen
 * desde el cursor, se desplazan y se desvanecen. Usan blend mode
 * aditivo para que los gradientes superpuestos se mezclen en tonos más
 * brillantes en vez de simplemente taparse unos a otros. Haz clic para
 * plantar un florecimiento; otros aparecen solos con el tiempo.
 */

ArrayList<Bloom> blooms = new ArrayList<Bloom>();

void setup() {
  size(640, 360);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  ellipseMode(RADIUS);
}

void draw() {
  blendMode(BLEND);
  background(0);
  blendMode(ADD);

  // aparecen florecimientos nuevos de vez en cuando por su cuenta
  if (frameCount % 40 == 0) {
    blooms.add(new Bloom(random(width), random(height)));
  }

  for (int i = blooms.size() - 1; i >= 0; i--) {
    Bloom b = blooms.get(i);
    b.update();
    b.display();
    if (b.isDead()) {
      blooms.remove(i);
    }
  }
}

void mousePressed() {
  blooms.add(new Bloom(mouseX, mouseY));
}

class Bloom {
  float x, y;
  float vx, vy;
  float age = 0;
  float lifespan;
  float maxRadius;
  float baseHue;

  Bloom(float x_, float y_) {
    x = x_;
    y = y_;
    vx = random(-0.3, 0.3);
    vy = random(-0.3, 0.3);
    lifespan = random(90, 180);
    maxRadius = random(40, 100);
    baseHue = random(360);
  }

  void update() {
    x += vx;
    y += vy;
    age++;
  }

  boolean isDead() {
    return age > lifespan;
  }

  void display() {
    float lifeT = age / lifespan;      // 0 -> 1 a lo largo de su vida
    float growth = sin(lifeT * PI);    // crece y luego se encoge
    float radius = maxRadius * growth;

    float hue = (baseHue + age * 1.5) % 360;

    for (float r = radius; r > 0; r -= 2) {
      float ringT = r / radius;
      float alpha = 40 * growth * (1 - ringT);  // se desvanece hacia el borde
      fill((hue + ringT * 60) % 360, 85, 100, alpha);
      ellipse(x, y, r, r);
    }
  }
}
