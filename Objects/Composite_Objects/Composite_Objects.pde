/**
 * Composite Objects
 * 
 * An object can include several other objects. Creating such composite objects 
 * is a good way to use the principles of modularity and build higher levels of 
 * abstraction within a program.
 */

EggRing er1, er2;


void setup() {
  size(800, 450);

  // Huevo 1: pequeño y movimiento lento
  er1 = new EggRing(width*0.30, height*0.45, 8, 100, 0.04);

  // Huevo 2: grande y movimiento rápido
  er2 = new EggRing(width*0.70, height*0.60, 2, 200, 0.20);
}


void draw() {
  background(20);

  er1.transmit();
  er2.transmit();
}
