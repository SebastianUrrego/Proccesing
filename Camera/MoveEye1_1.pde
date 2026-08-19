/**
 * Move Eye. 
 * by Simon Greenwold.
 * 
 * The camera lifts up (controlled by mouseY) while looking at the same point.
 */

void setup() {
  size(640, 360, P3D);
  fill(204);
}

void draw() {
  lights();
  background(0);
  
  // Change height of the camera with mouseY
  // Usar mouseX y mouseY para controlar posición
  camera(mouseX - width/2, mouseY - height/2, 220.0,  // eyeX, eyeY
       0.0, 0.0, 0.0,  // center
       0.0, 1.0, 0.0); // up
  
  noStroke();
  box(90);
  stroke(255);
  line(-100, 0, 0, 100, 0, 0);
  line(0, -100, 0, 0, 100, 0);
  line(0, 0, -100, 0, 0, 100);
}
