MovingBar[] bars = new MovingBar[4];

void setup() {
  size(640, 360);
  
  bars[0] = new MovingBar(width/2, 8, 1.0/16.0, color(255, 100, 100), 0, height/2);
  bars[1] = new MovingBar(width/2, 36, 1.0/64.0, color(100, 100, 255), 0, height/2);
  bars[2] = new MovingBar(width/2, 8, -1.0/16.0, color(255, 100, 100), height/2, height/2);
  bars[3] = new MovingBar(width/2, 36, -1.0/64.0, color(100, 100, 255), height/2, height/2);
}

void draw() {
  // Cambiamos el valor de opacidad de 50 a 15 para que el rastro dure mucho más tiempo en pantalla
  fill(0, 15); 
  noStroke();
  rect(0, 0, width, height);
  
  float targetMx = mouseX * 0.4 - width / 5.0;
  float mx = lerp(0, targetMx, 0.2); 
  
  for (MovingBar bar : bars) {
    bar.update(mx);
    bar.display();
  }
}

class MovingBar {
  float x, y, w, h;
  float speedFactor;
  color baseColor;
  
  MovingBar(float startX, float widthVal, float speedVal, color col, float posY, float heightVal) {
    x = startX;
    w = widthVal;
    speedFactor = speedVal;
    baseColor = col;
    y = posY;
    h = heightVal;
  }
  
  void update(float mx) {
    x += mx * speedFactor;
    
    if (x < -w) {
      x = width;
    } else if (x > width) {
      x = -w;
    }
  }
  
  void display() {
    float strokeOscillation = sin(millis() * 0.002) * 127 + 128;
    
    for (float i = 0; i < w; i++) {
      color gradientC = lerpColor(color(255), baseColor, i / w);
      stroke(gradientC);
      line(x + i, y, x + i, y + h);
    }
  }
}
