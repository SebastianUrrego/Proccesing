/**
 * Points and Lines. 
 * 
 * Points and lines can be used to draw basic geometry.
 * Change the value of the variable 'd' to scale the form.
 * The four variables set the positions based on the value of 'd'. 
 */
int d = 90;
int p1 = d;
int p2 = p1+d;
int p3 = p2+d;

size(640, 360);
noSmooth();
background(255);
translate(140, 0);

// Triángulo
stroke(0);
line(p1, p3, p3, p3); // base
line(p1, p3, p2, p1); // lado izquierdo
line(p2, p1, p3, p3); // lado derecho

// Puntos
stroke(253);
point(p1, p3);
point(p2, p1);
point(p3, p3);
