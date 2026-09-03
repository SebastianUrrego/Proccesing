float max_distance;

void setup() {
  size(640, 360); 
  noStroke();
  max_distance = dist(0, 0, width, height);
  colorMode(HSB, 360, 100, 100);
}

void draw() {
  // Fondo negro limpio sin rastro acumulado
  background(0);

  for (int i = 0; i <= width; i += 20) {
    for (int j = 0; j <= height; j += 20) {
      
      float dMouse = dist(mouseX, mouseY, i, j);
      
      float wave = sin(dMouse * 0.05 - millis() * 0.005) * 10;
      float shapeSize = (dMouse / max_distance) * 55 + wave;
      shapeSize = max(shapeSize, 2);

      float hueVal = (dMouse * 0.5 + millis() * 0.05) % 360;
      float brightnessVal = map(dMouse, 0, max_distance, 100, 30);
      
      fill(hueVal, 80, brightnessVal);

      pushMatrix();
      translate(i, j);
      
      if ((i + j) % 40 == 0) {
        ellipse(0, 0, shapeSize, shapeSize);
      } else {
        rotate(millis() * 0.001 + dMouse * 0.01);
        rectMode(CENTER);
        rect(0, 0, shapeSize * 0.8, shapeSize * 0.8);
      }
      
      popMatrix();
    }
  }
}
