/**
 * Integers Floats. 
 * 
 * Integers and floats are two different kinds of numerical data. 
 * An integer (more commonly called an int) is a number without 
 * a decimal point. A float is a floating-point number, which means 
 * it is a number that has a decimal place. Floats are used when
 * more precision is needed. 
 */
 
int a = 0;        // Create a variable "a" of the datatype "int"
float b = 640.0;  // Create a variable "b" of the datatype "float"

void setup() {
  size(640, 360);
  stroke(255);
}

void draw() {
  background(0);
  
  a = a + 1;      // Arriba: lento hacia la derecha
  b = b - 3.0;    // Abajo: rápido hacia la izquierda
  
  line(a, 0, a, height/3);    // Barra de arriba más corta
  line(b, height/2, b, height); // Barra de abajo más larga
  
  if(a > width) {
    a = 0;
  }
  
  if(b < 0) {
    b = width;
  }
}
```
